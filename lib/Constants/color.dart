import 'package:flutter/material.dart';

class AppColors{
  static const Color dark = Colors.black;
  static const Color light = Colors.white;
  static const Color yellow = Color(0xFFfdbf00);
  static const Color yellowDark = Color(0xFFe48400);
  static const Color red = Color(0xFFD32F2F);
  static const Color orange = Color(0xFFfe8101);
  static const Color grey = Color(0xFFE0E0E0);
  static const Color lightbox = Color(0xFF9E9E9E);
  static const Color darkbox =   Color(0xFF26242e);

  static const LinearGradient mygradient = LinearGradient(colors: [
    Color(0xFFe48400),
     Color(0xFFfdbf00),
  ],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight
  );
 
}

class Spref {
  static const String isLight = "isLight";
}