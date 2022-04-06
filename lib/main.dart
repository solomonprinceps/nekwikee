import 'package:flutter/material.dart';
import 'routes/app_route.dart';
import 'themes/apptheme.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import 'styles.dart';
import 'package:kwikee1/services/notification.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';


const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  importance: Importance.high,
  playSound: true
);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   await Firebase.initializeApp();
//   // print('A bg message just showed up :  ${message.messageId}');
//   print('background message ${message.notification!.body}');
//   // Get.toNamed("/profile/changepin", arguments: 0);
//   // Navigator.pushNamed(context, routeName)
// }

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PushNotificationService().setupInteractedMessage();
  // await Firebase.initializeApp();
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // await flutterLocalNotificationsPlugin
  //     .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
  //     ?.createNotificationChannel(channel);

      

  // await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
  //   alert: true,
  //   badge: true,
  //   sound: true,
  // );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}
enum ConfirmAction { Cancel, Accept}  
class _MyAppState extends State<MyApp> {
  Timer? _timer;
  @override
  void initState() {
    super.initState();
    _logOutUser(context);
    _initializeTimer(context);
    currentTheme.addListener(() {
      setState(() {});
    });
    
  }

  void _initializeTimer(BuildContext context) {
    _timer = Timer.periodic(const Duration(minutes: 3), (_) => _logOutUser(context));
    print("set timer");
  }

  void _logOutUser(BuildContext context) async {
    // Log out the user if they're logged in, then cancel the timer.
    // You'll have to make sure to cancel the timer if the user manually logs out
    //   and to call _initializeTimer once the user logs in
    print("logout");
    // _asyncConfirmDialog(context);
     print('I am 401');
    SharedPreferences authstorage = await SharedPreferences.getInstance();
    String? token  = authstorage.getString("accessToken");
    if (token != null) {
      authstorage.remove('user');
      authstorage.remove('accessToken');
      Get.offAllNamed("/auth/login");
      _timer?.cancel();
      _timer = Timer.periodic(const Duration(minutes: 3), (_) => _logOutUser(context));
    }
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(minutes: 3), (_) => _logOutUser(context));
  }

  // You'll probably want to wrap this function in a debounce
  
  void _handleUserInteraction([_]) {
    if (!_timer!.isActive) {
      // This means the user has been logged out
      return;
    }

    _timer!.cancel();
    _initializeTimer(context);
    
  }

  Future<ConfirmAction?> _asyncConfirmDialog(BuildContext context) async {  
    return showDialog<ConfirmAction>(  
      context: context,  
      barrierDismissible: false, // user must tap button for close dialog!  
      builder: (BuildContext context) {  
        return MaterialApp(
          home: AlertDialog(  
            title: Text('Are you still here?'),  
            content: const Text('You will be logout if you click Accept'),  
            actions: <Widget>[  
              TextButton(  
                child: const Text('Cancel'),  
                onPressed: () {  
                  Navigator.of(context).pop(ConfirmAction.Cancel);  
                },  
              ),  
              TextButton(  
                child: const Text('Accept'),  
                onPressed: () {  
                  Navigator.of(context).pop(ConfirmAction.Accept);  
                },  
              )  
            ],  
          ),
        );  
      },  
    );  
  } 


  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: CustomTheme.presntstate ? HexColor('#303753') : Colors.white,
    ));
    return GlobalLoaderOverlay(
      useDefaultLoading: false,
      overlayColor: Colors.white30,
      overlayWidget: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget> [
            SpinKitFadingCube(
              color: primary,
              size: 50.0,
            ),
          ],
        ),
      ),
      overlayOpacity: 0.8,
      child: Sizer(
        builder: (context, orientation, deviceType) {
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onPanDown:  _handleUserInteraction,
            onScaleStart: _handleUserInteraction,
            onTap: () {
              _handleUserInteraction();
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus &&
                  currentFocus.focusedChild != null) {
                FocusManager.instance.primaryFocus?.unfocus();
              }
            },  
            child: GetMaterialApp(
              title: 'Kwikee',
              debugShowCheckedModeBanner: false,
              theme: CustomTheme.lightTheme,
              darkTheme: CustomTheme.darkTheme,
              themeMode: currentTheme.currentTheme,     
              // themeMode: ThemeMode.light,
              // initialRoute: '/credit/preview',
              initialRoute: '/newsplash',
              getPages: approutlist
            ),
          );
        },
      )
    );
  }
}
