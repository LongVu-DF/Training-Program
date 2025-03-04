import 'package:basic_layout/data/datasources/todo_data_source.dart';
import 'package:basic_layout/data/repositories/todo_repository.dart';
import 'package:basic_layout/domain/usecase/add_todo_usecase.dart';
import 'package:basic_layout/domain/usecase/delete_todo_usecase.dart';
import 'package:basic_layout/domain/usecase/get_todo_usecase.dart';
import 'package:basic_layout/domain/usecase/has_done_todo_usecase.dart';
import 'package:basic_layout/presentation/blocs/todo_bloc.dart';
import 'package:basic_layout/core/theme/color_theme.dart';
import 'package:basic_layout/presentation/screens/my_home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.system;
  late final todoDataSource = TodoDataSource();
  late final repository = TodoRepositoryImpl(todoDataSource);
  late final getTodoUseCase = GetTodoUseCase(repository);
  late final addTodoUseCase = AddTodoUsecase(repository);
  late final deleteTodoUseCase = DeleteTodoUsecase(repository);
  late final hasDoneTodoUseCase = HasDoneTodoUsecase(repository);
  // late final todoBloc = TodoBloc(repository);
  _changeTheme(bool text) {
    setState(() {
      _themeMode = text ? ThemeMode.light : ThemeMode.dark;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) => TodoBloc(
            getTodoUseCase: getTodoUseCase,
            addTodoUsecase: addTodoUseCase,
            deleteTodoUsecase: deleteTodoUseCase,
            hasDoneTodoUsecase: hasDoneTodoUseCase,
          ),
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
