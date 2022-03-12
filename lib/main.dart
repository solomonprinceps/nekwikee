import 'package:flutter/material.dart';
import 'routes/app_route.dart';
import 'themes/apptheme.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import 'styles.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    currentTheme.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return GlobalLoaderOverlay(
      useDefaultLoading: false,
      overlayColor: Colors.white30,
      overlayWidget: Center(
        child: Container(
          padding: const EdgeInsets.all(10),
          alignment: Alignment.center,
          height: 50,
          width: 120,
          decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.circular(10)
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SpinKitFadingCircle(
                color: primary,
                size: 30.0,
              ),
              const SizedBox(width: 7),
              Text(
                'loading...',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                  color: Colors.black,
                  fontFamily: GoogleFonts.actor().toString(),  
                ),
              )
            ],
          ),
        ),
      ),
      overlayOpacity: 0.8,
      child: Sizer(
        builder: (context, orientation, deviceType) {
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
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
              initialRoute: '/first',
              // initialRoute: '/onboard',
              getPages: approutlist
            ),
          );
        },
      )
    );
  }
}
