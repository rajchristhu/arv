import 'package:arv/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData appPrimaryTheme() => ThemeData(
      brightness: Brightness.light,
      primaryColor: Colors.white,
      scaffoldBackgroundColor: Colors.white,
      cardColor: Colors.white,
      snackBarTheme:  SnackBarThemeData(
        backgroundColor: appColor,
        contentTextStyle: TextStyle(color: Colors.white),
        actionTextColor: Colors.white,
      ),
      appBarTheme: const AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle.light,
        color: Colors.white,
        elevation: 1.0,
        actionsIconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      dividerColor: Colors.grey[300],
      dividerTheme: const DividerThemeData(thickness: 0.5),
      tabBarTheme: TabBarTheme(
        labelColor: Colors.black,
        unselectedLabelColor: Colors.grey,
        indicatorSize: TabBarIndicatorSize.tab,
        labelStyle: GoogleFonts.poppins(
          fontSize: 12.0,
          fontWeight: FontWeight.w700,
        ),
        unselectedLabelStyle: GoogleFonts.poppins(
          fontSize: 12.0,
          fontWeight: FontWeight.w500,
        ),
      ),
      textTheme: TextTheme(
        headline3: GoogleFonts.poppins(
          fontSize: 32.0,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        headline4: GoogleFonts.poppins(
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        headline5: GoogleFonts.poppins(
          fontSize: 18.0,
          fontWeight: FontWeight.w400,
          color: Colors.black,
        ),
        headline6: GoogleFonts.poppins(
          fontSize: 15.0,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
        subtitle1: GoogleFonts.poppins(
          fontSize: 16.0,
          fontWeight: FontWeight.w400,
          color: Colors.black,
        ),
        subtitle2: GoogleFonts.poppins(
          fontSize: 14.0,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
        bodyText1: GoogleFonts.poppins(
          fontSize: 15.0,
          fontWeight: FontWeight.w400,
          color: Colors.black,
        ),
        bodyText2: GoogleFonts.poppins(
          fontSize: 12.0,
          fontWeight: FontWeight.w400,
          color: Colors.black,
        ),
        button: GoogleFonts.poppins(
          fontSize: 14.0,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
    );
