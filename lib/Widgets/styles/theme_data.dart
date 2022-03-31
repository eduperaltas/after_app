// @dart=2.9
import 'package:flutter/material.dart';
import 'package:after_app/Widgets/styles/colors.dart';

const TextStyle basicTextStyle = TextStyle(
  fontFamily: "SFUIDisplay",
  fontWeight: FontWeight.normal,
  fontSize: 16.0,
);

 TextTheme textTheme = TextTheme(
  bodyText1: basicTextStyle,
  bodyText2: basicTextStyle.merge(const TextStyle(fontSize: 14.0)),
  titleLarge: basicTextStyle.merge(
    const TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: 30.0,
    ),
  ),
  subtitle1: basicTextStyle.merge(
    const TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 12.0,
    ),
  ),
);

class ThemeScheme {
  static dark() {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: dbackgroundColor,
      primaryColor: Color(0xffAD8B19),
      accentColor: Color(0xffAD8B19),
      // textTheme: textTheme,
      appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(color: Colors.white),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey[400],
          ),
        ),
      ),
    );
  }

  static ThemeData light() {
    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: lbackgroundColor,
      primaryColor: Color(0xffAD8B19),
      accentColor:  Color(0xffAD8B19),
      // textTheme: textTheme,
      appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(color: dbasicDarkColor),
      ),
      inputDecorationTheme: InputDecorationTheme(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFFF6F7F7),
          ),
        ),
      ),
    );
  }
}
