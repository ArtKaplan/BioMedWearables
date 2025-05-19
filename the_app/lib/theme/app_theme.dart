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
      //backgroundColor: Colors.blue,
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(fontSize: 57, fontWeight: FontWeight.bold, color: Color(0xFF66101F)),
      headlineSmall: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF66101F)),

      titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: Color(0xFF66101F)),

      bodyLarge: TextStyle(fontSize: 16, color: Colors.black87), // Fließtext
      bodyMedium: TextStyle(fontSize: 14, color: Colors.black87),

      labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF884D5C)), // z. B. für Buttons
      labelSmall: TextStyle(fontSize: 12, color: Color(0xFF7A7A7A)), // Hilfstext, Datum, etc.
    ),
  );


  static final ThemeData darkTheme = ThemeData(
    fontFamily: GoogleFonts.ubuntu().fontFamily,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xFF1C1B1F), // warm-dunkelgrau
    appBarTheme: AppBarTheme(
      color: const Color(0xFF1C1B1F),
      titleTextStyle: TextStyle(fontSize: 20, color: Color(0xFFFFF1D7)), // helles Beige
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Color(0xFFE6D4BA)),   // leicht beige
      bodyMedium: TextStyle(color: Color(0xFFE6D4BA)), // warm-hellgrau für Fließtext
      labelSmall: TextStyle(color: Color(0xFFBFA890)), // für Hilfstexte
    ),
  );

}
