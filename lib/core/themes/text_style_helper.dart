import 'package:cinematika/core/themes/theme_helper.dart';
import 'package:flutter/material.dart';

class TextStyleHelper {
  static TextStyleHelper? _instance;

  TextStyleHelper._();

  static TextStyleHelper get instance {
    _instance ??= TextStyleHelper._();
    return _instance!;
  }

  TextStyle get headline24Bold => TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Color(0xFF8E8E93),
      );


  TextStyle get title20RegularRoboto => TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w400,
        fontFamily: 'Roboto',
        color: Color(0xFF000000),
      );

  TextStyle get title17SemiBold => TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.w600,
        color: appTheme.whiteCustom,
      );

  TextStyle get body15 =>
      TextStyle(fontSize: 15, color: appTheme.whiteCustom);

  TextStyle get body15Light => TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w300,
        color: Color(0xFF8E8E93),
      );

  TextStyle get body15Medium => TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w500,
        color: Color(0xFF8E8E93),
      );

  TextStyle get body13Light => TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w300,
        color: appTheme.whiteCustom,
      );

  TextStyle get body13Medium => TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w500,
        color: Color(0xFF8E8E93),
      );

  TextStyle get body12ExtraBold => TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w800,
        color: appTheme.whiteCustom,
      );

  TextStyle get body12 =>
      TextStyle(fontSize: 12, color: Color(0xFF8E8E93));

  TextStyle get label10 =>
      TextStyle(fontSize: 10, color: Color(0xFF8E8E93));
}
