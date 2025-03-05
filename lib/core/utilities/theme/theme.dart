import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LightTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    textTheme: TextTheme(
      bodyLarge: TextStyle(
          color: Colors.black, fontFamily: GoogleFonts.poppins().fontFamily),
      bodyMedium: TextStyle(
          color: Colors.black, fontFamily: GoogleFonts.poppins().fontFamily),
      bodySmall: TextStyle(
          color: Colors.black, fontFamily: GoogleFonts.poppins().fontFamily),
      titleLarge: TextStyle(
          color: Colors.black, fontFamily: GoogleFonts.poppins().fontFamily),
      titleMedium: TextStyle(
          color: Colors.black, fontFamily: GoogleFonts.poppins().fontFamily),
      titleSmall: TextStyle(
          color: Colors.black, fontFamily: GoogleFonts.poppins().fontFamily),
      headlineLarge: TextStyle(
          color: Colors.black, fontFamily: GoogleFonts.poppins().fontFamily),
      headlineMedium: TextStyle(
          color: Colors.black, fontFamily: GoogleFonts.poppins().fontFamily),
      headlineSmall: TextStyle(
          color: Colors.black, fontFamily: GoogleFonts.poppins().fontFamily),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white, // White background
      hintStyle: TextStyle(
          color: Colors.grey,
          fontFamily: GoogleFonts.poppins().fontFamily), // Grey hint text
      labelStyle: TextStyle(
          color: Colors.black,
          fontFamily: GoogleFonts.poppins().fontFamily), // Label text color
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide:
            BorderSide(color: Colors.black), // Black border for light mode
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(color: Colors.blue), // Blue when focused
      ),
    ),
  );
}

class DarkTheme {
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    textTheme: TextTheme(
      bodyLarge: TextStyle(
          color: Colors.white, fontFamily: GoogleFonts.poppins().fontFamily),
      bodyMedium: TextStyle(
          color: Colors.white, fontFamily: GoogleFonts.poppins().fontFamily),
      bodySmall: TextStyle(
          color: Colors.white, fontFamily: GoogleFonts.poppins().fontFamily),
      titleLarge: TextStyle(
          color: Colors.white, fontFamily: GoogleFonts.poppins().fontFamily),
      titleMedium: TextStyle(
          color: Colors.white, fontFamily: GoogleFonts.poppins().fontFamily),
      titleSmall: TextStyle(
          color: Colors.white, fontFamily: GoogleFonts.poppins().fontFamily),
      headlineLarge: TextStyle(
          color: Colors.white, fontFamily: GoogleFonts.poppins().fontFamily),
      headlineMedium: TextStyle(
          color: Colors.white, fontFamily: GoogleFonts.poppins().fontFamily),
      headlineSmall: TextStyle(
          color: Colors.white, fontFamily: GoogleFonts.poppins().fontFamily),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.black, // Black background
      hintStyle: TextStyle(
          color: Colors.grey,
          fontFamily: GoogleFonts.poppins().fontFamily), // Grey hint text
      labelStyle: TextStyle(
          color: Colors.purple,
          fontFamily: GoogleFonts.poppins().fontFamily), // Purple label text
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(
          color: Colors.white,
        ), // Purple border for dark mode
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(color: Colors.blue), // Blue when focused
      ),
    ),
  );
}
