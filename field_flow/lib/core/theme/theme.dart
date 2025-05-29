import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors/app_colors.dart';
import 'colors/primary_swatch.dart';

class CustomThemeData {
  static ThemeData getThemeData() => ThemeData(
    appBarTheme: appBarTheme,
    drawerTheme: drawerThemeData,
    primarySwatch: primarySwatch,
    fontFamily: fontFamily,
    useMaterial3: useMaterial3,
    scaffoldBackgroundColor: scaffoldBackgroundColor,
    colorScheme: colorScheme,
    textTheme: textTheme,
  );

  static final appBarTheme = AppBarTheme(titleTextStyle: textTheme.titleMedium);
  static const drawerThemeData =
  DrawerThemeData(backgroundColor: AppColors.primaryColor);
  static const fontFamily = 'montserrat';
  static const useMaterial3 = false;
  static const scaffoldBackgroundColor = AppColors.primaryColor;
  static final colorScheme = ColorScheme.fromSeed(
    seedColor: AppColors.primaryColor,
    primary: AppColors.primaryColor,
  );

  static final textTheme = TextTheme(
    displayLarge: GoogleFonts.montserrat(
        fontSize: 21,
        fontWeight: FontWeight.w400),
    displayMedium: GoogleFonts.montserrat(
        color: AppColors.primaryColor, fontWeight: FontWeight.w600, fontSize: 16),
    displaySmall: GoogleFonts.montserrat(color: AppColors.primaryColor),
    headlineMedium: GoogleFonts.montserrat(color: AppColors.primaryColor),
    headlineSmall: GoogleFonts.montserrat(color: AppColors.primaryColor),
    titleLarge: GoogleFonts.montserrat(
        color: Colors.black,
        fontSize: 18,
        fontWeight: FontWeight.w500),
    titleMedium: GoogleFonts.montserrat(
        color: Colors.black,
        fontSize: 16,
        fontWeight: FontWeight.w700),
    titleSmall: GoogleFonts.montserrat(color: AppColors.primaryColor),
    bodyLarge: GoogleFonts.montserrat(color: AppColors.primaryColor),
    bodyMedium: GoogleFonts.montserrat(
        color: Colors.black,
        fontSize: 14,
        fontWeight: FontWeight.w500),
    bodySmall: GoogleFonts.montserrat(
        color: Colors.black,
        fontSize: 12,
        fontWeight: FontWeight.w500),
    labelLarge: GoogleFonts.montserrat(
        color: Colors.black.withOpacity(.8),
        fontSize: 14,
        fontWeight: FontWeight.w700),
    labelMedium: GoogleFonts.montserrat(
        color: Colors.black,
        fontSize: 12,
        fontWeight: FontWeight.w500),
    labelSmall: GoogleFonts.montserrat(
        color: Colors.black.withOpacity(.7),
        fontSize: 12,
        fontWeight: FontWeight.w500),
  );

}