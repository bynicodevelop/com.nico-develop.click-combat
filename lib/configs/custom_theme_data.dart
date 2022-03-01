import 'package:com_nico_develop_click_combat/configs/constants.dart';
import 'package:flutter/material.dart';

class CustomThemeData {
  static final ThemeData defaultTheme = _buildCustomThemeData();

  static ThemeData _buildCustomThemeData() {
    final ThemeData base = ThemeData.light();

    return base.copyWith(
      scaffoldBackgroundColor: kDefaultBackgroundColor,
      appBarTheme: const AppBarTheme(
        color: kDefaultBackgroundColor,
        elevation: 0,
        iconTheme: IconThemeData(
          color: kDefautColor,
        ),
        titleTextStyle: TextStyle(
          color: kDefautColor,
          fontSize: 20,
          fontWeight: FontWeight.w400,
          letterSpacing: kDefaultPadding / 15,
        ),
      ),
      textTheme: const TextTheme(
        bodyText1: TextStyle(
          color: kDefautColor,
          fontSize: kDefaultFontSize,
          fontWeight: FontWeight.w400,
        ),
        bodyText2: TextStyle(
          color: Color(0xFFA3A3A3),
          fontStyle: FontStyle.italic,
          fontSize: kDefaultFontSize / 1.1,
          fontWeight: FontWeight.w400,
          letterSpacing: .7,
        ),
        caption: TextStyle(
          color: kDefautColor,
          fontSize: kDefaultFontSize / 1.2,
          fontWeight: FontWeight.w500,
          letterSpacing: 1.2,
        ),
        headline1: TextStyle(
          color: kDefautColor,
          fontSize: kDefaultFontSize * 1.9,
          fontWeight: FontWeight.w400,
        ),
        headline4: TextStyle(
          color: kDefautColor,
          fontSize: kDefaultFontSize * 1.2,
          fontWeight: FontWeight.w400,
        ),
        headline6: TextStyle(
          color: kDefautColor,
          fontSize: kDefaultFontSize * 1.5,
          fontWeight: FontWeight.w400,
        ),
        subtitle1: TextStyle(
          color: kDefautColor,
          fontSize: kDefaultFontSize,
          fontWeight: FontWeight.w400,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          primary: kDefautColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              kDefaultPadding / 3,
            ),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.all(kDefaultPadding / 1.2),
        labelStyle: TextStyle(
          color: Colors.grey[800]!,
          fontSize: kDefaultFontSize,
          fontWeight: FontWeight.w400,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            kDefaultPadding / 4,
          ),
          borderSide: BorderSide(
            width: 1,
            color: Colors.grey[500]!,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            kDefaultPadding / 4,
          ),
          borderSide: BorderSide(
            width: 1,
            color: Colors.grey[500]!,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            kDefaultPadding / 4,
          ),
          borderSide: BorderSide(
            width: 1,
            color: Colors.grey[500]!,
          ),
        ),
      ),
    );
  }
}
