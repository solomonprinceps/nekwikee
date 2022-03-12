import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kwikee1/styles.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';

CustomTheme currentTheme = CustomTheme();

class CustomTheme with ChangeNotifier {
  static bool _isDarkTheme = false; 
  ThemeMode get currentTheme => _isDarkTheme ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme(bool state) {
    _isDarkTheme = !state;
    notifyListeners();
    // print(_isDarkTheme);
  }

  checkstate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? themestate = prefs.getBool("themestate");
    return themestate;
  }

  static bool get presntstate { 
    // print(_isDarkTheme);
    return _isDarkTheme; 
  }

  static ThemeData get lightTheme {
    return ThemeData(
      
      primaryColor: Colors.lightBlue,
      // accentColor: primary,
      backgroundColor: Colors.white,
      // cursorColor: Colors.red,
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: Colors.blue
      ),
      colorScheme: ColorScheme.light(
        // contencolor: HexColor("#f8f8f8"),
        primary: HexColor("#f8f8f8"),
        onPrimary: primary,
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
        backgroundColor: Colors.transparent,
        elevation: 0
      ),
      bottomAppBarTheme: const BottomAppBarTheme(
        shape: CircularNotchedRectangle(),
        
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      primaryColor: Colors.black,
      colorScheme: ColorScheme.dark(
        primary: dackmodedashboardcaard,
        onPrimary: darkwhite,
        secondary: creditcolordark
      ),
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: Colors.blue
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        contentPadding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 10.0),
        fillColor: inputcolordark,
        border: inputborder,
        focusedBorder: activeinputborder,
        enabledBorder: inputborder,
        focusedErrorBorder:inputborder ,
        errorBorder: errorborder,
        disabledBorder: inputborder,
        errorStyle: const TextStyle(color: Colors.red),
      ),
      backgroundColor: Colors.grey,
      unselectedWidgetColor:  const Color.fromRGBO(112, 112, 112, 1),
      scaffoldBackgroundColor: HexColor('#131B39'),
      textTheme: GoogleFonts.livvicTextTheme(),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0
      ),
      bottomAppBarTheme: BottomAppBarTheme(
        shape: const CircularNotchedRectangle(),
        color: HexColor('#303753')
      ),
      checkboxTheme: CheckboxThemeData(
        // fillColor: Colors.blue
      )
    );
  }
}