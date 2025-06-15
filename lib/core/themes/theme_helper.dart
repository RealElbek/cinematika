import 'package:cinematika/core/themes/pref_utils.dart';
import 'package:flutter/material.dart';

LightCodeColors get appTheme => ThemeHelper().themeColor();
ThemeData get theme => ThemeHelper().themeData();

class ThemeHelper {

  final _appTheme = PrefUtils().getThemeData();


  final Map<String, LightCodeColors> _supportedCustomColor = {
    'lightCode': LightCodeColors(),
  };


  final Map<String, ColorScheme> _supportedColorScheme = {
    'lightCode': ColorSchemes.lightCodeColorScheme,
  };


  LightCodeColors _getThemeColors() {
    return _supportedCustomColor[_appTheme] ?? LightCodeColors();
  }


  ThemeData _getThemeData() {
    var colorScheme =
        _supportedColorScheme[_appTheme] ?? ColorSchemes.lightCodeColorScheme;
    return ThemeData(
      visualDensity: VisualDensity.standard,
      colorScheme: colorScheme,
    );
  }


  LightCodeColors themeColor() => _getThemeColors();


  ThemeData themeData() => _getThemeData();
}

class ColorSchemes {
  static final lightCodeColorScheme = ColorScheme.light();
}

class LightCodeColors {

  Color get white => Color(0xFFFFFFFF);
  Color get gray400 => Color(0xFF9CA3AF);

  Color get whiteCustom => Colors.white;
  Color get transparentCustom => Colors.transparent;
  Color get greenCustom => Colors.green;
  Color get colorFF1212 => Color(0xFF121212);
  Color get colorFF2AB1 => Color(0xFF2AB156);
  Color get colorFF498F => Color(0xFF498FE1);
  Color get color7FFFFF => Color(0x7FFFFFFF);
  Color get color81FFFF => Color(0x81FFFFFF);
  Color get colorFF1616 => Color(0xFF161616);
  Color get color1E8E8E => Color(0x1E8E8E93);
  Color get color6DFFFF => Color(0x6DFFFFFF);
  Color get color872AB1 => Color(0x872AB156);

  Color get grey200 => Colors.grey.shade200;
  Color get grey100 => Colors.grey.shade100;
}
