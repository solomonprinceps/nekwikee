import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kwikee1/styles.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';

CustomTheme currentTheme = CustomTheme();

class CustomTheme with ChangeNotifier {
  static bool _isDarkTheme = true; 
  ThemeMode get currentTheme => _isDarkTheme ? ThemeMode.dark : ThemeMode.light;
  CustomTheme() {
    checkstate();
  }
  void toggleTheme(bool state) {
    _isDarkTheme = !state;
    updatethemestorage(!state);
    notifyListeners();
  }

  updatethemestorage(bool state) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("themestate", state).then((value) => print(value));
  }

  checkstate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? themestate =  prefs.getBool("themestate");
    if (themestate == true) {
      _isDarkTheme = themestate!;
      notifyListeners();
    }
    if(themestate == null) {
      _isDarkTheme = false;
      notifyListeners();
    }
    if (themestate == false) {
      _isDarkTheme = themestate!;
      notifyListeners();
    }
    // print('Theme state $themestate');
  }

  static bool get presntstate { 
    // print(_isDarkTheme);
    return _isDarkTheme; 
  }

  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: Colors.lightBlue,
      // accentColor: primary,
      primarySwatch: Colors.blue,
      backgroundColor: Colors.white,
      // cursorColor: Colors.red,
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: Colors.blue
      ),
      colorScheme: ColorScheme.light(
        // contencolor: HexColor("#f8f8f8"),
        // primary: HexColor("#f8f8f8"),
        // onPrimary: primary,
        secondary: creditcolordark
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        contentPadding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 10.0),
        fillColor: inputColor,
        border: inputborder,
        focusedBorder: activeinputborder,
        enabledBorder: inputborder,
        focusedErrorBorder:inputborder ,
        errorBorder: errorborder,
        disabledBorder: inputborder,
        errorStyle: const TextStyle(color: Colors.red),
      ),
      scaffoldBackgroundColor: HexColor('#ffffff'),
      textTheme: GoogleFonts.livvicTextTheme(),
      appBarTheme: const AppBarTheme(
        centerTitle: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.dark, // 2
      ),
      bottomAppBarTheme: BottomAppBarTheme(
        shape: CircularNotchedRectangle(),
        color: HexColor('#CCCCCC').withOpacity(0.46)
        
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      primaryColor: Colors.white,
      primarySwatch: Colors.blue,
      colorScheme: ColorScheme.dark(
        // primary: dackmodedashboardcaard,
        // onPrimary: darkwhite,
        secondary: creditcolordark
      ),
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: Colors.blue
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        contentPadding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 10.0),
        fillColor: inputdarkcool,
        border: inputborder,
        focusedBorder: activeinputborder,
        enabledBorder: inputborder,
        focusedErrorBorder:inputborder,
        errorBorder: errorborder,
        disabledBorder: inputborder,
        errorStyle: const TextStyle(color: Colors.red),
      ),
      backgroundColor: Colors.grey,
      unselectedWidgetColor:  const Color.fromRGBO(112, 112, 112, 1),
      scaffoldBackgroundColor: HexColor('#131B39'),
      textTheme: GoogleFonts.livvicTextTheme(),
      appBarTheme: const AppBarTheme(
        centerTitle: false,
        backgroundColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        elevation: 0
      ),
      // bottomAppBarTheme: BottomAppBarTheme(
      //   shape: const CircularNotchedRectangle(),
      //   color: white
      // ),
  
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: darkbottomtype,
        selectedLabelStyle: TextStyle(
          color: iconcolorselected,
          fontWeight: FontWeight.w600,
          fontSize: 10
        ),
        unselectedLabelStyle: TextStyle(
          color: white,
          fontWeight: FontWeight.w600,
          fontSize: 10
        ),
      ),
      checkboxTheme: CheckboxThemeData(
        // fillColor: Colors.blue
      )
    );
  }
}