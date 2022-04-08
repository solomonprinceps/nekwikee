import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:kwikee1/styles.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:kwikee1/themes/apptheme.dart';
import './home/first.dart';
import './home/savings.dart';
import 'package:get/get.dart';
import 'package:kwikee1/controllers/authcontroller.dart';
import 'package:kwikee1/services/datstruct.dart';
import 'home/profile.dart';
import 'package:upgrader/upgrader.dart';
import 'package:new_version/new_version.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';



class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  AuthController auth = Get.find<AuthController>();
  CustomTheme currentheme = CustomTheme();
  final newVersion = NewVersion(
    androidId: 'com.moneymarquefinance.kwikee',
  );
  dynamic passedid;
  int? index = 0;
  int notiy = 0;
  final pages =  <Widget>[
    const Savings(),
    const First(),
    const Profile()
    // TextButton(
    //   onPressed: () { currentTheme.toggleTheme(CustomTheme.presntstate); },
    //   child: const Text("change theme")
    // ),
  ];
  _callNumber() async {
    const number = '012299997'; //set the number here
    await FlutterPhoneDirectCaller.callNumber(number);
  }
  getoken() async {
    await _firebaseMessaging.getToken().then((value) {
      sendtoken(value!);
    });
  }

  sendtoken(String token) async {
    Map data = {
      "email": auth.userdata["email"],
      "token": token
    };
    await auth.updateToken(data).then((value) {
      print(value);
    });
  }

  void onChangedTab(int index) {
    setState(() {
      this.index = index;
    });
  }

  void changetab(int ind) {
    setState(() {
      index = ind;
    });
  }

  AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    // 'This channel is used for important notifications.', // description
    importance: Importance.high,
    playSound: true);
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();



  @override
  void initState() {
    getoken();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published! xoxo');
      setState(() {
        notiy = notiy + 1;
      });
      // Get.toNamed("/home", arguments: 1);
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              // channel.description,
              color: Colors.blue,
              playSound: true,
              icon: '@mipmap/launcher_icon',
            ),
          )
        );
      }
    });

    

    setState(() {
      passedid = Get.arguments;
    });
    if (passedid != null) {
      setState(() {
        index = passedid;
      });
    }
    // const simpleBehavior = true;
    basicStatusCheck(newVersion);
    super.initState();
  }



  basicStatusCheck(NewVersion newVersion) {
    newVersion.showAlertIfNecessary(context: context);
  }

  advancedStatusCheck(NewVersion newVersion) async {
    final status = await newVersion.getVersionStatus();
    if (status != null) {
      debugPrint(status.releaseNotes);
      debugPrint(status.appStoreLink);
      debugPrint(status.localVersion);
      debugPrint(status.storeVersion);
      debugPrint(status.canUpdate.toString());
      newVersion.showUpdateDialog(
        context: context,
        versionStatus: status,
        dialogTitle: 'Custom Title',
        dialogText: 'Custom Text',
      );
    }
  }


  void showNotification() {
    print("object");
    flutterLocalNotificationsPlugin.show(
      0,
      "Testing push",
      "How you doin ?",
      NotificationDetails(
        android: AndroidNotificationDetails(channel.id, channel.name,
          importance: Importance.high,
          color: Colors.blue,
          playSound: true,
          icon: '@mipmap/ic_launcher'
        )
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    // final String themestate =
    //     MediaQuery.of(context).platformBrightness == Brightness.light
    //         ? "light"
    //         : "dark";

    return Scaffold(
      appBar: index == 2 ? PreferredSize(preferredSize: Size(0.0, 0.0),child: Container(),) : PreferredSize(
        preferredSize: Size.fromHeight(40.0),
        child: AppBar(
          title: Obx(() => Text(
              "Yo! ${makecapitalize(auth.userdata["firstname"].toString())},",
          
              // "Yo! ${auth.userdata["firstname"].capitalize()}",
              // 'Hi ${auth.userdata["lastname"]},',
              softWrap: false,
              style: TextStyle(
                color: CustomTheme.presntstate ? white : primary,
                fontSize: 15,
                fontWeight: FontWeight.w600
              ),
            )
          ),
          automaticallyImplyLeading: false,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Row(
                children: [
      
                  InkWell(
                    onTap: () => _callNumber(),
                    child: SvgPicture.asset(
                      'assets/image/support.svg',
                      semanticsLabel: 'Target',
                      width: 20,
                      height: 20,
                      // color: white,
                    ),
                  ),
                  SizedBox(width: 20),
                  
                  InkWell(
                    onTap: () {
                      setState(() {
                        notiy = 0;
                      });
                      Get.toNamed("notification");
                    },
                    // onTap: () => getoken(),
                    child: Badge(
                      badgeColor: notiy != 0 ? error : Colors.transparent,
                      badgeContent:  notiy != 0 ? Text(
                        notiy.toString(),
                        style: TextStyle(
                          color: white,
                          fontSize: 10
                        ),
                      ): Container(),
                      child: Icon(
                        FontAwesome.bell,
                        color: registerActioncolor,
                        size: 25.0,
                        textDirection: TextDirection.ltr,
                        semanticLabel:
                            'Icon', // Announced in accessibility modes (e.g TalkBack/VoiceOver). This label does not show in the UI.
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index!,
        selectedItemColor: iconcolorselected,
        onTap: (val) {
          // print(val);
          if (val == 0) {
            setState(() {
              index = 0;
            });
          }
          if (val == 1) {
            setState(() {
              index = 1;
            });
          }
          if (val == 2) {
            setState(() {
              index = 2;
            });
          }
        },
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
          icon:  SvgPicture.asset(
            index == 0
                ? 'assets/image/lightnavicon/savingsactive.svg'
                : 'assets/image/lightnavicon/savings.svg',
            semanticsLabel: 'Savings',
            // color: index == 1 ? iconcolorselected : iconcolor,
            // color: Colors.red,
          ),
          label: 'Savings',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            index == 1
                ? 'assets/image/lightnavicon/homeactive.svg'
                : 'assets/image/lightnavicon/home.svg',
            semanticsLabel: 'Home Icon',
            // color: index == 0 ? iconcolorselected : iconcolor,
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            index == 2
                ?
                // profileIconactive.svg
                'assets/image/lightnavicon/profileactive.svg'
                : 'assets/image/lightnavicon/profile.svg',
            semanticsLabel: 'money bill',
            // color: index == 2 ? iconcolorselected : iconcolor,
          ),
          label: 'Profile',
        ),
        ],
      ),
      // bottomNavigationBar: Container(
      //   decoration: BoxDecoration(
      //     borderRadius: BorderRadius.circular(5),
      //     color: !CustomTheme.presntstate ? HexColor('#CCCCCC').withOpacity(0.46) : darkbottomtype
      //   ),
      //   height: 60,
      //   child: Padding(
      //     padding: const EdgeInsets.only(left: 20, right: 20, top: 10, ),
      //     child: Row(
      //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //       crossAxisAlignment: CrossAxisAlignment.center,
      //       children: [
      //         InkWell(
      //           onTap: () => changetab(1),
      //           child: Column(
      //             children: [
                    // SvgPicture.asset(
                    //   index == 1
                    //       ? 'assets/image/savingactive.svg'
                    //       : 'assets/image/savinginactive.svg',
                    //   semanticsLabel: 'Savings',
                    //   // color: index == 1 ? iconcolorselected : iconcolor,
                    //   // color: Colors.red,
                    // ),
      //               Text(
      //                 "Savings",
      //                 style: TextStyle(
      //                   color: !CustomTheme.presntstate ? index == 1 ? iconcolorselected : black : index == 1 ? iconcolorselected : white,
      //                   fontWeight: index == 1 ? FontWeight.w600 : FontWeight.w500,
      //                   fontSize: 10
      //                 ),
      //               )
      //             ],
      //           ),
      //         ),
      //         InkWell(
      //           onTap: () => changetab(0),
      //           child: Column(
      //             children: [
                    // SvgPicture.asset(
                    //   index == 0
                    //       ? 'assets/image/homeIconactive.svg'
                    //       : 'assets/image/homeIcon.svg',
                    //   semanticsLabel: 'Home Icon',
                    //   // color: index == 0 ? iconcolorselected : iconcolor,
                    // ),
      //               Text(
      //                 "Home",
      //                 style: TextStyle(
      //                   color: !CustomTheme.presntstate ? index == 0 ? iconcolorselected : black : index == 0 ? iconcolorselected : white,
      //                   fontWeight: index == 0 ? FontWeight.w600 : FontWeight.w500,
      //                   fontSize: 10
      //               ),
      //               )
      //             ],
      //           ),
      //         ),
      //         InkWell(
      //           onTap: () => changetab(2),
      //           child: Column(
      //             children: [
                    // SvgPicture.asset(
                    //   index == 2
                    //       ?
                    //       // profileIconactive.svg
                    //       'assets/image/profileIconactive.svg'
                    //       : 'assets/image/profileIcon.svg',
                    //   semanticsLabel: 'money bill',
                    //   // color: index == 2 ? iconcolorselected : iconcolor,
                    // ),
      //               Text(
      //                 "Profile",
      //                 style: TextStyle(
      //                  color: !CustomTheme.presntstate ? index == 2 ? iconcolorselected : black : index == 2 ? iconcolorselected : white,
      //                   fontWeight: index == 2 ? FontWeight.w600 : FontWeight.w500,
      //                   fontSize: 10
      //                 ),
      //               )
      //             ],
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
      body: UpgradeAlert(child: pages[index!]),
    );
  }
}
