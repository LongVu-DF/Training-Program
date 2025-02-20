import 'package:flutter/material.dart';

final lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: const Color(0xFF5d2514),
  scaffoldBackgroundColor: const Color(0xff000000),
  colorScheme: ColorScheme.light(
    primary: const Color(0xFF8f4c38),
    secondary: const Color(0xFF77574e),
    tertiary: const Color(0xFF6c5d2f),
    error: const Color(0xFFba1a1a),
    surface: const Color(0xFFfff8f6),

    primaryContainer: const Color(0xFFffdbd1),
    secondaryContainer: const Color(0xFFffdbd1),
    tertiaryContainer: const Color(0xFFf5e1a7),
    errorContainer: const Color(0xFFffdad6),
    surfaceContainer: const Color(0xFFfceae5),

    onPrimary: const Color(0xFFffffff),
    onSecondary: const Color(0xFFffffff),
    onTertiary: const Color(0xFFffffff),
    onError: const Color(0xFFffffff),
    onPrimaryContainer: const Color(0xFF723523),
    onSecondaryContainer: const Color(0xFF5d4037),
    onTertiaryContainer: const Color(0xFF534619),
    onErrorContainer: const Color(0xFF93000a),
    onSurface: const Color(0xFF231917),
    onSurfaceVariant: const Color(0xff53433f),
    onInverseSurface: const Color(0xffffede8),

    surfaceDim: const Color(0xFFe8d6d2),
    surfaceBright: const Color(0xFFfff8f6),
    outline: const Color(0xFF85736e),
    outlineVariant: const Color(0xFFd8c2bc),

    inversePrimary: const Color(0xffffb5a0),
    inverseSurface: const Color(0xff392e2b),
  ),
);

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: const Color(0xFFffb5a0),
  scaffoldBackgroundColor: const Color(0xFF000000),
  colorScheme: ColorScheme.dark(
    primary: const Color(0xFFffb5a0),
    secondary: const Color(0xFFe7bdb2),
    tertiary: const Color(0xFFd8c58d),
    error: const Color(0xFFffb4ab),
    surface: const Color(0xFF1a110f),

    primaryContainer: const Color(0xFF723523),
    secondaryContainer: const Color(0xFF5d4037),
    tertiaryContainer: const Color(0xFF534619),
    errorContainer: const Color(0xFF93000a),
    surfaceContainer: const Color(0xFF271d1b),

    onPrimary: const Color(0xFF561f0f),
    onSecondary: const Color(0xFF442a22),
    onTertiary: const Color(0xff3b2f05),
    onError: const Color(0xFF690005),
    onPrimaryContainer: const Color(0xFFffdbd1),
    onSecondaryContainer: const Color(0xFFffdbd1),
    onTertiaryContainer: const Color(0xFFf5e1a7),
    onErrorContainer: const Color(0xFFffdad6),
    onSurface: const Color(0xFFf1dfda),
    onSurfaceVariant: const Color(0xffd8c2bc),
    onInverseSurface: const Color(0xff392e2b),

    surfaceDim: const Color(0xFF1a110f),
    surfaceBright: const Color(0xFF423734),
    outline: const Color(0xFFa08c87),
    outlineVariant: const Color(0xFF53433f),

    inversePrimary: const Color(0xff8f4c38),
    inverseSurface: const Color(0xfff1dfda),
  ),
);
