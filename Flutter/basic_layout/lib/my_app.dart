import 'package:basic_layout/custom_theme.dart';
import 'package:basic_layout/my_home_page.dart';
import 'package:flutter/material.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // ignore: prefer_final_fields
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
      home: MyHomePage(title: 'Flutter Demo Home Page', onCall: _changeTheme),
    );
  }
}
