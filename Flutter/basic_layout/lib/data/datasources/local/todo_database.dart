import 'dart:async';
import 'package:basic_layout/data/models/dao/todo_dao.dart';
import 'package:floor/floor.dart';
import 'package:sqflite_common/sqlite_api.dart' as sqflite;
part 'todo_database.g.dart';

@Database(version: 1, entities: [TodoDAO])
abstract class TodoDatabase extends FloorDatabase {
  TodoDao get todoDao;
}
