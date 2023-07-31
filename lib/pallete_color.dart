import 'package:flutter/material.dart';

class Palette {
  static const MaterialColor kToDark = MaterialColor(
    0xFF6171ba, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    <int, Color>{
      50: Color(0xFF6171ba), //10%
      100: Color(0xFF6171ba), //20%
      200: Color(0xFF6171ba), //30%
      300: Color(0xFF6171ba), //40%
      400: Color(0xFF6171ba), //50%
      500: Color(0xFF6171ba), //60%
      600: Color(0xFF6171ba), //70%
      700: Color(0xFF6171ba), //80%
      800: Color(0xFF6171ba), //90%
      900: Color(0xFF6171ba), //100%
    },
  );
  static const MaterialColor bgColor = MaterialColor(
    0xFFDBDBDB, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    <int, Color>{
      50: Color(0xFFDBDBDB), //10%
      // 100:  Color(0xffb74c3a),//20%
      // 200:  Color(0xffa04332),//30%
      // 300:  Color(0xff89392b),//40%
      // 400:  Color(0xff733024),//50%
      // 500:  Color(0xff5c261d),//60%
      // 600:  Color(0xff451c16),//70%
      // 700:  Color(0xff2e130e),//80%
      // 800:  Color(0xff170907),//90%
      // 900:  Color(0xff000000),//100%
    },
  );
}
