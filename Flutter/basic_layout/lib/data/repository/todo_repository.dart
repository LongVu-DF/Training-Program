import 'package:basic_layout/data/datasources/todo_data_source.dart';
import 'package:basic_layout/data/models/todo_model.dart';
import 'package:flutter/widgets.dart';

class TodoRepository with ChangeNotifier {
  final TodoDataSource todoDataSource = TodoDataSource();
  late final List<ToDo> _todo = todoDataSource.getTodoDataSource();
  List<ToDo> get todo => _todo.where((todo) => todo.done == false).toList();
  List<ToDo> get done => _todo.where((todo) => todo.done == true).toList();

  List<ToDo> fetchToDo() {
    return todo;
  }

  List<ToDo> fetchDone() {
    return done;
  }

  void addTodo({
    String title = '',
    String description = '',
    String time = '',
    bool done = false,
  }) {
    _todo.add(ToDo(title, description, time, done, _todo.last.id + 1));
    notifyListeners();
  }

  void deleteTodo(int id) {
    _todo.removeWhere((item) => item.id == id);
    notifyListeners();
  }

  void updateTodo(int id) {
    int index = _todo.indexWhere((todo) => todo.id == id);
    _todo[index].done = !_todo[index].done;
    notifyListeners();
  }
}

abstract class TodoRepositoryInterface {
  List<ToDo> fetchTodo();
  List<ToDo> fetchDone();

  void addTodo();
  void deleteTodo();
  void updateTodo();
}

class TodoRepositoryImpl implements TodoRepositoryInterface {
  final TodoDataSource todoDataSource = TodoDataSource();
  late final List<ToDo> _todo = todoDataSource.getTodoDataSource();
  List<ToDo> get todo => _todo.where((todo) => todo.done == false).toList();
  List<ToDo> get done => _todo.where((todo) => todo.done == true).toList();

  @override
  List<ToDo> fetchTodo() {
    return todo;
  }

  @override
  List<ToDo> fetchDone() {
    return done;
  }

  @override
  void addTodo() {}
  @override
  void deleteTodo() {}
  @override
  void updateTodo() {}
}
