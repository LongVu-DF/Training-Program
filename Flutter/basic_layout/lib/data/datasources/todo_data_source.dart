import 'package:basic_layout/data/models/todo_model.dart';

class TodoDataSource {
  static final TodoDataSource _instance = TodoDataSource._internal();
  factory TodoDataSource() => _instance;
  TodoDataSource._internal();
  final List<ToDo> _todo = [
    ToDo('item 1', 'description 1', 'time 1', false, 1),
    ToDo('item 2', 'description 2', 'time 2', false, 2),
    ToDo('item 3', 'description 3', 'time 3', false, 3),
    ToDo('item 4', 'description 4', 'time 4', false, 4),
    ToDo('item 5', 'description 5', 'time 5', false, 5),
  ];
  List<ToDo> getTodoDataSource() {
    return _todo;
  }
}
