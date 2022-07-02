import 'package:flutter/material.dart';

class Themes {
  static final colorList = [
    const Color(0xFF0095F9),
    const Color(0xFF4CAF50),
    const Color(0xFF002B82),
    const Color(0xFF872574),
    const Color(0xFFC52830),
    const Color(0xFFDDA3B2),
    const Color(0xFF2D7D93),
    const Color(0xFF919FC5),
    const Color(0xFF638190),
  ];

  static final themeList = colorList
      .map((e) => {
            "light":
                ThemeData(colorSchemeSeed: e, brightness: Brightness.light),
            "dark": ThemeData(colorSchemeSeed: e, brightness: Brightness.dark),
          })
      .toList();


}
