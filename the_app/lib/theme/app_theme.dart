import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    fontFamily: GoogleFonts.ubuntu().fontFamily,
    scaffoldBackgroundColor: const Color(0xFFFFF1D7),
    
    brightness: Brightness.light,
    //primaryColor: Colors.blue,
    appBarTheme: AppBarTheme(
      color: const Color(0xFFFFF1D7),
      titleTextStyle: TextStyle(fontSize: 20, color: Color(0xFF66101F)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor:Color(0xFFDE7C5A),
        foregroundColor: Color(0xFF66101F)
      )
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor:Color(0xFF66101F)),
    ),
    dialogTheme: DialogThemeData(
      backgroundColor: const Color(0xFFFFF1D7)
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(fontSize: 57, fontWeight: FontWeight.bold, color: Color(0xFF66101F)),
      headlineSmall: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF66101F)),

      titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: Color(0xFF66101F)),

      bodyLarge: TextStyle(fontSize: 16, color: Color(0xFF66101F)), // Fließtext
      bodyMedium: TextStyle(fontSize: 14, color: Color(0xFF66101F)),

      labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFFFFF1D7)), // buttons
      labelMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFFDE7C5A)), // buttons
      labelSmall: TextStyle(fontSize: 12, color: Color(0xFFFFF1D7)), //for helptexts
    ),
  );


  static final ThemeData darkTheme = ThemeData(
    fontFamily: GoogleFonts.ubuntu().fontFamily,
    scaffoldBackgroundColor: const Color(0xFF66101F),
    
    brightness: Brightness.light,
    //primaryColor: Colors.blue,
    appBarTheme: AppBarTheme(
      color: const Color(0xFF66101F),
      titleTextStyle: TextStyle(fontSize: 20, color: Color(0xFFFFF1D7)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor:Color(0xFFDE7C5A),
        foregroundColor: Color(0xFF66101F)
      )
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor:Color(0xFFFFF1D7)),
    ),
    dialogTheme: DialogThemeData(
      backgroundColor: const Color(0xFF66101F)
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(fontSize: 57, fontWeight: FontWeight.bold, color: Color(0xFF66101F)),
      headlineSmall: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFFFFF1D7)),

      titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: Color(0xFFFFF1D7)),

      bodyLarge: TextStyle(fontSize: 16, color: Color(0xFFFFF1D7)), // Fließtext
      bodyMedium: TextStyle(fontSize: 14, color: Color(0xFFFFF1D7)),

      labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF66101F)), // buttons
      labelMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFFDE7C5A)), // buttons
      labelSmall: TextStyle(fontSize: 12, color: Color(0xFF66101F)), //for helptexts
    ),
  );

}
