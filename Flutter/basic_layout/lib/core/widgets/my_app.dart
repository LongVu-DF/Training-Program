import 'package:basic_layout/core/ui/theme/color_theme.dart';
import 'package:basic_layout/core/widgets/my_home_page.dart';
import 'package:flutter/material.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.system;

  _changeTheme(bool text) {
    setState(() {
      _themeMode = text ? ThemeMode.light : ThemeMode.dark;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      darkTheme: darkTheme,
      theme: lightTheme,
      themeMode: _themeMode,
      home: MyHomePage(title: 'To-Do List', onCall: _changeTheme),
    );
  }
}
