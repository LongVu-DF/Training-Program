import 'package:basic_layout/core/blocs/todo_bloc.dart';
import 'package:basic_layout/core/theme/color_theme.dart';
import 'package:basic_layout/core/widgets/my_home_page.dart';
import 'package:basic_layout/data/repository/todo_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.system;
  final repository = TodoRepositoryImpl();
  // late final todoBloc = TodoBloc(repository);
  _changeTheme(bool text) {
    setState(() {
      _themeMode = text ? ThemeMode.light : ThemeMode.dark;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodoBloc(repository),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        darkTheme: ThemeData(
          useMaterial3: true,
          colorScheme: MaterialTheme.darkScheme(),
        ),
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: MaterialTheme.lightScheme(),
        ),
        themeMode: _themeMode,
        home: MyHomePage(title: 'To-Do List', onCall: _changeTheme),
      ),
    );
  }
}
