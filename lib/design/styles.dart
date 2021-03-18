import 'dart:ui';

import 'package:flutter/material.dart';

 class Styles {
   
  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    return ThemeData(

      primarySwatch: Colors.red,
      primaryColor: isDarkTheme ? Color(0xff0F0501) : Colors.white,

      backgroundColor: isDarkTheme ? Colors.grey : Color(0xffF1F5FB),

      indicatorColor: isDarkTheme ? Color(0xff0E1D36) : Color(0xffCBDCF8),
      buttonColor: isDarkTheme ? Color(0xff3B3B3B) : Color(0xffF1F5FB),

      hintColor: isDarkTheme ? Color(0xff280C0B) : Color(0xffEECED3),

      highlightColor: isDarkTheme ? Color(0xff372901) : Color(0xffFCE192),
      hoverColor: isDarkTheme ? Colors.white : Colors.red,

      focusColor: isDarkTheme ? Colors.red : Colors.black,
      disabledColor: Colors.grey,
      textSelectionColor: isDarkTheme ? Colors.white : Colors.black,

      // titles textTheme
      textTheme: Theme.of(context).textTheme.copyWith(
        headline6: isDarkTheme ? TextStyle(color: Colors.red, fontSize: 26.0) : TextStyle(color: Colors.black, fontSize: 26.0),
        button: isDarkTheme ? TextStyle(color: Colors.white, fontSize: 18.0) : TextStyle(color: Colors.black, fontSize: 18.0),
      ),
      
      

      cardColor: isDarkTheme ? Color(0xFF27140A) : Colors.white,
      canvasColor: isDarkTheme ? Color(0xff212121) : Colors.grey[50],
      brightness: isDarkTheme ? Brightness.light : Brightness.light,
      buttonTheme: Theme.of(context).buttonTheme.copyWith(
          colorScheme: isDarkTheme ? ColorScheme.dark() : ColorScheme.light()),
      appBarTheme: AppBarTheme(
        elevation: 0.0,
      ),
    );
    
  }
}