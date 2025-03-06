import 'package:basic_layout/data/datasources/local/todo_database.dart';
import 'package:basic_layout/presentation/my_app.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final database =
      await $FloorTodoDatabase.databaseBuilder('todo_database.db').build();
  runApp(MyApp(database));
}
