import 'package:flutter/material.dart';

import '../Providers/SettingsProvider.dart';
import '../Resources/Themes.dart';

class ThemeUtil {
  static getNowTheme() {
    int themeIndex = SettingsProvider().getThemeIndex();
    if (themeIndex == -1) {
      /// 自定义主题
      String themeCustomeColor = SettingsProvider().getThemeCustomColor();
      return _getColorSuite(getColorFromHex(themeCustomeColor));
    } else {
      return _getColorSuite(Themes.colorList[themeIndex]);
    }
  }

  static _getColorSuite(Color color) {
    ThemeData tdLight =
        ThemeData(colorSchemeSeed: color, brightness: Brightness.light);
    ThemeData tdDark =
        ThemeData(colorSchemeSeed: color, brightness: Brightness.dark);
    // Color primaryThemeColor = tdLight.primaryColor;
    // ThemeData tdDarkFinal = tdDark.copyWith(
    //   appBarTheme: AppBarTheme(
    //     color: primaryThemeColor,
    //   ),
    //   textButtonTheme: TextButtonThemeData(
    //     style: TextButton.styleFrom(
    //       primary: Colors.white,
    //       backgroundColor: primaryThemeColor,
    //     ),
    //   ),
    // );
    return {
      "light": tdLight,
      "dark": tdDark,
    };
  }

  static Color getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    return Color(int.parse(hexColor, radix: 16));
  }
}
