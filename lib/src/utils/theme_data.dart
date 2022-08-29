import 'package:engagementwallet/src/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../values/radii.dart';


ThemeData myThemeData(BuildContext context) {
  return ThemeData(
    primaryColor: primaryColor,
    colorScheme: ColorScheme.light(
        primary: primaryColor,
        secondary:secondaryColor),
    scaffoldBackgroundColor: whiteColor,
    backgroundColor: whiteColor,
    brightness: Brightness.light,
    fontFamily: GoogleFonts.sourceSansPro().fontFamily,
    textTheme: GoogleFonts.sourceSansProTextTheme(),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: TextStyle(color: greyColor, fontSize: 14),
      hintStyle: TextStyle(color: blackColor, fontSize: 14),
      fillColor: whiteColor,
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: primaryColor,
            width: 1,
          ),
          borderRadius: Radii.k10pxRadius),
      disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: primaryColor,
            width: 1,
          ),
          borderRadius: Radii.k10pxRadius),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: primaryColor,
              width: 1.5,
              style: BorderStyle.solid),
          borderRadius: Radii.k10pxRadius),
      border: OutlineInputBorder(
          borderSide: BorderSide(
            color: primaryColor,
            width: 1,
          ),
          borderRadius: Radii.k10pxRadius),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(primaryColor),
      ),
    ),
    buttonTheme: ButtonThemeData(
      colorScheme: ColorScheme.light(
        primary: primaryColor,
      ),
      splashColor: greyColor,
      textTheme: ButtonTextTheme.normal,
      buttonColor: primaryColor,
    ),
  );
}
