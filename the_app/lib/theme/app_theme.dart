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
    textTheme: const TextTheme(
      displayLarge: TextStyle(fontSize: 57, fontWeight: FontWeight.bold, color: Color(0xFF66101F)),
      headlineSmall: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF66101F)),

      titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: Color(0xFF66101F)),

      bodyLarge: TextStyle(fontSize: 16, color: Colors.black87), // Fließtext
      bodyMedium: TextStyle(fontSize: 14, color: Colors.black87),

      labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFFFFF1D7)), // buttons
      labelSmall: TextStyle(fontSize: 12, color: Color(0xFF7A7A7A)), //for helptexts
    ),
  );


  static final ThemeData darkTheme = ThemeData(
    fontFamily: GoogleFonts.ubuntu().fontFamily,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xFF1C1B1F),
    appBarTheme: AppBarTheme(
      color: const Color.fromARGB(255, 157, 156, 158),
      titleTextStyle: TextStyle(fontSize: 20, color: Color(0xFF66101F)),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Color(0xFFE6D4BA)), // buttons
      bodyMedium: TextStyle(color: Color(0xFFE6D4BA)),
      labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFFFFF1D7)), // buttons//for regular text
      labelSmall: TextStyle(color: Color(0xFFBFA890)), // for helptexts
    ),
  );

}
