// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locum_care/core/themes/design_system.dart';

class Clr {
  // Core Colors
  Color primaryColor;
  Color primaryColorLight;
  Color primaryColorDark;
  Color secondaryHeaderColor;
  Color scaffoldBackgroundColor;
  Color dialogBackgroundColor;
  Color cardColor;
  Color canvasColor;
  Clr({
    required this.primaryColor,
    required this.primaryColorLight,
    required this.primaryColorDark,
    required this.secondaryHeaderColor,
    required this.scaffoldBackgroundColor,
    required this.dialogBackgroundColor,
    required this.cardColor,
    required this.canvasColor,
  });
}

final lightClr = Clr(
  primaryColor: Color(0xFF4169E1),
  primaryColorLight: Color(0xFF6A91F0),
  primaryColorDark: Color(0xFF2747A7),
  secondaryHeaderColor: Color(0xFF27774A),
  scaffoldBackgroundColor: Color(0xFFF5F5F5),
  dialogBackgroundColor: Color(0xFFE0FFFF),
  cardColor: Color(0xFFFFFFFF),
  canvasColor: Color(0xFFF5F5F5),
);
final darkClr = Clr(
  primaryColor: Color(0xFF5A7FFF),
  primaryColorDark: Color(0xFF2A4FBF),
  primaryColorLight: Color(0xFF7A9FFF),
  secondaryHeaderColor: Color(0xFF66CDAA),
  scaffoldBackgroundColor: Color(0xFF121212), //
  dialogBackgroundColor: Color(0xFF1A1A1A),
  cardColor: Color(0xFF1E1E1E),
  canvasColor: Color(0xFF121212), //
);

final ThemeData lightTheme = ThemeData(
  // Core Colors
  primaryColor: lightClr.primaryColor,
  primaryColorLight: lightClr.primaryColorLight,
  primaryColorDark: lightClr.primaryColorDark,
  secondaryHeaderColor: lightClr.secondaryHeaderColor,
  scaffoldBackgroundColor: lightClr.scaffoldBackgroundColor,
  cardColor: lightClr.cardColor,
  canvasColor: lightClr.scaffoldBackgroundColor,

  // Typography
  // fontFamily: 'Roboto', // Use the 'Roboto' font
  // textTheme:  TextTheme(
  //   headline1: TextStyle(fontSize: 96, fontWeight: FontWeight.bold, color: Colors.black),
  //   headline2: TextStyle(fontSize: 60, fontWeight: FontWeight.bold, color: Colors.black),
  //   headline3: TextStyle(fontSize: 48, fontWeight: FontWeight.normal, color: Colors.black),
  //   headline4: TextStyle(fontSize: 34, fontWeight: FontWeight.normal, color: Colors.black),
  //   headline5: TextStyle(fontSize: 24, fontWeight: FontWeight.normal, color: Colors.black),
  //   headline6: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
  //   subtitle1: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.normal, color: Colors.black),
  //   subtitle2: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: Colors.black),
  //   bodyText1: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.normal, color: Colors.black87),
  //   bodyText2: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.normal, color: Colors.black87),
  //   button: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: Colors.white),
  //   caption: TextStyle(fontSize: 12, fontWeight: FontWeight.normal, color: Colors.black54),
  //   overline: TextStyle(fontSize: 10, fontWeight: FontWeight.normal, color: Colors.black54),
  // ),

  // Buttons
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: lightClr.primaryColor, // Button background color
      foregroundColor: Colors.white, // Button text color
      shadowColor: lightClr.primaryColorDark, // Button shadow color
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      textStyle: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      foregroundColor: lightClr.primaryColor, // Button text color
      side: BorderSide(color: lightClr.primaryColor), // Border color
      textStyle: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: lightClr.primaryColor, // Text color
      textStyle: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
    ),
  ),

  // AppBar
  appBarTheme: AppBarTheme(
    backgroundColor: lightClr.primaryColor,
    foregroundColor: Colors.white, // Text and icon color
    elevation: 4,
    centerTitle: true,
    titleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
  ),

  // FloatingActionButton
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: lightClr.primaryColor, // Primary color
    foregroundColor: Colors.white, // Icon color
  ),

  // Input Fields
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(DesSys.borderRadiusMd)),
      borderSide: BorderSide(color: lightClr.secondaryHeaderColor),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(DesSys.borderRadiusMd)),
      borderSide: BorderSide(color: lightClr.secondaryHeaderColor),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(DesSys.borderRadiusMd)),
      borderSide: BorderSide(color: lightClr.primaryColorDark),
    ),
    labelStyle: TextStyle(color: lightClr.secondaryHeaderColor, fontSize: 16.sp),
    hintStyle: TextStyle(color: lightClr.secondaryHeaderColor, fontSize: 14.sp),
  ),

  // Divider
  dividerColor: Color(0xFFBDBDBD),

  // Icons
  iconTheme: IconThemeData(
    color: lightClr.secondaryHeaderColor, // Primary color for icons
  ),
  primaryIconTheme: IconThemeData(
    color: Colors.white, // White icons for primary elements
  ),

  // SnackBar
  snackBarTheme: SnackBarThemeData(
    backgroundColor: lightClr.primaryColor,
    contentTextStyle: TextStyle(color: Colors.white, fontSize: 16.sp),
  ),

  // bottom navigatio bar theme
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: lightClr.secondaryHeaderColor, // Highlight color
    unselectedItemColor: Colors.grey,
    showUnselectedLabels: true,
    selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
    unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500),
  ),
  dialogTheme: DialogThemeData(backgroundColor: lightClr.secondaryHeaderColor),
);

final ThemeData darkTheme = ThemeData(
  // Core Colors
  brightness: Brightness.dark,
  primaryColor: darkClr.primaryColor,
  primaryColorDark: darkClr.primaryColorDark,
  primaryColorLight: darkClr.primaryColorLight,
  scaffoldBackgroundColor: darkClr.scaffoldBackgroundColor,
  cardColor: darkClr.cardColor,
  secondaryHeaderColor: darkClr.secondaryHeaderColor,
  canvasColor: darkClr.scaffoldBackgroundColor,

  // Typography
  // fontFamily: 'Roboto', // Use the 'Roboto' font
  // textTheme:  TextTheme(
  //   headline1: TextStyle(fontSize: 96, fontWeight: FontWeight.bold, color: Colors.white),
  //   headline2: TextStyle(fontSize: 60, fontWeight: FontWeight.bold, color: Colors.white),
  //   headline3: TextStyle(fontSize: 48, fontWeight: FontWeight.normal, color: Colors.white),
  //   headline4: TextStyle(fontSize: 34, fontWeight: FontWeight.normal, color: Colors.white),
  //   headline5: TextStyle(fontSize: 24, fontWeight: FontWeight.normal, color: Colors.white),
  //   headline6: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
  //   subtitle1: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.normal, color: Colors.white70),
  //   subtitle2: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: Colors.white70),
  //   bodyText1: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.normal, color: Colors.white70),
  //   bodyText2: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.normal, color: Colors.white70),
  //   button: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: Colors.white),
  //   caption: TextStyle(fontSize: 12, fontWeight: FontWeight.normal, color: Colors.white54),
  //   overline: TextStyle(fontSize: 10, fontWeight: FontWeight.normal, color: Colors.white54),
  // ),

  // Buttons
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: darkClr.primaryColor, // Button background color
      foregroundColor: Colors.white, // Button text color
      shadowColor: darkClr.primaryColorDark, // Button shadow color
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      textStyle: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      foregroundColor: darkClr.primaryColor, // Button text color
      side: BorderSide(color: darkClr.primaryColor), // Border color
      textStyle: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: darkClr.primaryColor, // Text color
      textStyle: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
    ),
  ),

  // AppBar
  appBarTheme: AppBarTheme(
    backgroundColor: darkClr.primaryColor,
    foregroundColor: Colors.white, // Text and icon color
    elevation: 4,
    centerTitle: true,
    titleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
  ),

  // FloatingActionButton
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: darkClr.primaryColor, // Primary color
    foregroundColor: Colors.white, // Icon color
  ),

  // Input Fields
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: darkClr.cardColor, // Dark grey background for inputs
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(DesSys.borderRadiusMd)),
      borderSide: BorderSide(color: darkClr.secondaryHeaderColor),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(DesSys.borderRadiusMd)),
      borderSide: BorderSide(color: darkClr.secondaryHeaderColor),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(DesSys.borderRadiusMd)),
      borderSide: BorderSide(color: darkClr.secondaryHeaderColor),
    ),
    labelStyle: TextStyle(color: darkClr.secondaryHeaderColor, fontSize: 16.sp),
    hintStyle: TextStyle(color: darkClr.secondaryHeaderColor, fontSize: 14.sp),
  ),

  // Divider
  dividerColor: Color(0xFF888888),

  // Icons
  iconTheme: IconThemeData(
    color: darkClr.secondaryHeaderColor, // Secondary color for icons
  ),
  primaryIconTheme: IconThemeData(
    color: Colors.white, // White icons for primary elements
  ),

  // SnackBar
  snackBarTheme: SnackBarThemeData(
    backgroundColor: darkClr.primaryColor,
    contentTextStyle: TextStyle(color: Colors.white, fontSize: 16.sp),
  ),
  // bottom navigatio bar theme
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: darkClr.secondaryHeaderColor, // Highlight color
    unselectedItemColor: Colors.grey,
    showUnselectedLabels: true,
    selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
    unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500),
  ),
  dialogTheme: DialogThemeData(backgroundColor: darkClr.dialogBackgroundColor),
);
