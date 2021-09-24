import 'package:flutter/material.dart';

class ColorPalette {
  static const MaterialColor customColor = MaterialColor(
    0xFF7748E5, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    <int, Color>{
      50: Color(0xFFCE4198), //10%
      100: Color(0xFFB73AA2), //20%
      200: Color(0xFFA03291), //30%
      300: Color(0xFF892B84), //40%
      400: Color(0xFF732468), //50%
      500: Color(0xFFC5349A), //60%
      600: Color(0xFF451643), //70%
      700: Color(0xff2e130e), //80%
      800: Color(0xFF170716), //90%
      900: Color(0xff000000), //100%
    },
  );
}
