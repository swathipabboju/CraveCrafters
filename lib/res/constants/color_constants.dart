import 'package:flutter/material.dart';

class AppColors {
  static const Color appbarColour = Color.fromARGB(255, 223, 179, 59);
  static const Color primaryTransparent = Color(0x401D3654);
  static const Color black = Colors.black;
  static const Color white = Colors.white;
  static const Color orange = Colors.white;
  static const Color lightBlue = Color(0xFF8AC6FC); // Added color #8ac6fc
  static const Color lavender = Color(0xFFCDCDFC); // Added color #cdcdfc
  static const Color softBlue = Color(0xFFB5C7F9);
  static const MaterialColor appbarSwatch = MaterialColor(
    0xFF123456, // The main color
    <int, Color>{
      50: Color(0xFFE3F2FD),
      100: Color(0xFFBBDEFB),
      200: Color(0xFF90CAF9),
      300: Color(0xFF64B5F6),
      400: Color(0xFF42A5F5),
      500: Color(0xFF2196F3), // Primary color
      600: Color(0xFF1E88E5),
      700: Color(0xFF1976D2),
      800: Color(0xFF1565C0),
      900: Color(0xFF0D47A1),
    },
  );

  // #8ac6fc
  //#cdcdfc
  //#b5c7f9
}
