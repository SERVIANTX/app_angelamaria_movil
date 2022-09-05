
//Librerias de flutter
import 'package:flutter/material.dart';

const int _primaryColor = 0xFF6366F1;
const MaterialColor primarySwatch = MaterialColor(_primaryColor, <int, Color>{
  50: Color(0xFFEEF2FF),
  100: Color(0xFFE0E7FF),
  200: Color(0xFFC7D2FE),
  300: Color(0xFFA5B4FC),
  400: Color(0xFF818CF8),
  500: Color(_primaryColor),
  600: Color(0xFF4F46E5),
  700: Color(0xFF4338CA),
  800: Color(0xFF3730A3),
  900: Color(0xFF312E81),
});

const int _textColor = 0xFF64748B;
const MaterialColor textSwatch = MaterialColor(_textColor, <int, Color>{
  50: Color(0xFFF8FAFC),
  100: Color(0xFFF1F5F9),
  200: Color(0xFFE2E8F0),
  300: Color(0xFFCBD5E1),
  400: Color(0xFF94A3B8),
  500: Color(_textColor),
  600: Color(0xFF475569),
  700: Color(0xFF334155),
  800: Color(0xFF1E293B),
  900: Color(0xFF0F172A),
});

final ThemeData lightTheme = ThemeData(
  highlightColor: Colors.white,
  primarySwatch: primarySwatch,
  brightness: Brightness.light,
  shadowColor: const Color.fromARGB(255, 158, 165, 173),
  scaffoldBackgroundColor: textSwatch.shade100,
  backgroundColor: const Color.fromRGBO(248, 248, 250, 1),
  cardColor: Colors.white,
  bottomAppBarColor: Colors.white,
  dividerColor: const Color(0x1C000000),
  canvasColor: textSwatch.shade700,
  indicatorColor: textSwatch.shade700,
  fontFamily: 'Nunito',
  textTheme: TextTheme(
    headline1: TextStyle(
      color: textSwatch.shade700,
      fontWeight: FontWeight.normal,
      fontFamily: 'Antipasto',
      fontSize: 24,
    ),
    headline2: TextStyle(
      color: textSwatch.shade700,
      fontWeight: FontWeight.normal,
      fontFamily: 'Nunito',
      fontSize: 20,
    ),
    headline3: TextStyle(
      color: textSwatch.shade700,
      fontWeight: FontWeight.normal,
      fontFamily: 'Antipasto',
      fontSize: 40,
    ),
    headline4: TextStyle(
      color: textSwatch.shade700,
      fontWeight: FontWeight.normal,
      fontFamily: 'Antipasto',
      fontSize: 18,
    ),
    headline5: TextStyle(
      color: textSwatch.shade600,
      fontWeight: FontWeight.normal,
      fontFamily: 'Antipasto',
      fontSize: 28,
    ),
    headline6: TextStyle(
      color: textSwatch.shade700,
      fontWeight: FontWeight.w500,
      fontFamily: 'Nunito',
    ),
    subtitle1: TextStyle(
      color: textSwatch.shade700,
      fontWeight: FontWeight.normal,
      fontFamily: 'Nunito',
    ),
    subtitle2: TextStyle(
      color: textSwatch.shade600,
      fontWeight: FontWeight.w500,
      fontFamily: 'Nunito',
    ),
    bodyText1: TextStyle(
      color: textSwatch.shade700,
      fontWeight: FontWeight.normal,
      fontFamily: 'Nunito',
    ),
    bodyText2: TextStyle(
      color: textSwatch.shade500,
      fontWeight: FontWeight.normal,
      fontFamily: 'Nunito',
    ),
    button: TextStyle(
      color: textSwatch.shade500,
      fontWeight: FontWeight.w500,
      fontFamily: 'Nunito',
    ),
    caption: TextStyle(
      color: textSwatch.shade500,
      fontWeight: FontWeight.normal,
      fontFamily: 'Nunito',
    ),
    overline: TextStyle(
      color: textSwatch.shade500,
      fontWeight: FontWeight.normal,
      fontFamily: 'Nunito',
    ),
  ),
);

final ThemeData darkTheme = lightTheme.copyWith(
  highlightColor: Colors.black,
  brightness: Brightness.dark,
  shadowColor: const Color.fromARGB(255, 158, 165, 173),
  scaffoldBackgroundColor: const Color(0xFF18181B),
  backgroundColor: const Color(0xFF18181B),
  cardColor: const Color(0xFF262626),
  bottomAppBarColor: const Color(0xFF27272A),
  dividerColor: const Color(0x1CFFFFFF),
  canvasColor: textSwatch.shade200,
  textTheme: TextTheme(
    headline1: TextStyle(
      color: textSwatch.shade200,
      fontWeight: FontWeight.normal,
      fontFamily: 'Antipasto',
      fontSize: 24,
    ),
    headline2: TextStyle(
      color: textSwatch.shade300,
      fontWeight: FontWeight.normal,
      fontFamily: 'Nunito',
      fontSize: 20,
    ),
    headline3: TextStyle(
      color: textSwatch.shade200,
      fontWeight: FontWeight.normal,
      fontFamily: 'Antipasto',
      fontSize: 40,
    ),
    headline4: TextStyle(
      color: textSwatch.shade200,
      fontWeight: FontWeight.normal,
      fontFamily: 'Antipasto',
      fontSize: 18,
    ),
    headline5: TextStyle(
      color: textSwatch.shade300,
      fontWeight: FontWeight.normal,
      fontFamily: 'Antipasto',
      fontSize: 28,
    ),
    headline6: TextStyle(
      color: textSwatch.shade200,
      fontWeight: FontWeight.w500,
      fontFamily: 'Nunito',
    ),
    subtitle1: TextStyle(
      color: textSwatch.shade200,
      fontWeight: FontWeight.normal,
      fontFamily: 'Nunito',
    ),
    subtitle2: TextStyle(
      color: textSwatch.shade300,
      fontWeight: FontWeight.w500,
      fontFamily: 'Nunito',
    ),
    bodyText1: TextStyle(
      color: textSwatch.shade300,
      fontWeight: FontWeight.normal,
      fontFamily: 'Nunito',
    ),
    bodyText2: TextStyle(
      color: textSwatch.shade200,
      fontWeight: FontWeight.normal,
      fontFamily: 'Nunito',
    ),
    button: TextStyle(
      color: textSwatch.shade400,
      fontWeight: FontWeight.w500,
      fontFamily: 'Nunito',
    ),
    caption: TextStyle(
      color: textSwatch.shade400,
      fontWeight: FontWeight.normal,
      fontFamily: 'Nunito',
    ),
    overline: TextStyle(
      color: textSwatch.shade400,
      fontWeight: FontWeight.normal,
      fontFamily: 'Nunito',
    ),
  ),
);