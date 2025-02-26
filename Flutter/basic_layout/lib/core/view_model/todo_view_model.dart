import 'package:basic_layout/data/models/todo_model.dart';
import 'package:basic_layout/data/repository/todo_repository.dart';
import 'package:flutter/widgets.dart';

class ToDoViewModel with ChangeNotifier {
  final TodoRepository _todoRepository = TodoRepository();

  List<ToDo> get todo => _todoRepository.fetchToDo();
  List<ToDo> get done => _todoRepository.fetchDone();

  ToDoViewModel() {
    _todoRepository.addListener(() {
      notifyListeners();
    });
  }

  void deleteTodo(int id) {
    _todoRepository.deleteTodo(id);
  }

  void addTodo({
    String title = '',
    String description = '',
    String time = '',
    bool done = false,
  }) {
    _todoRepository.addTodo(
      title: title,
      time: time,
      description: description,
      done: done,
    );
  }

  void updateTodo(int id) {
    _todoRepository.updateTodo(id);
  }
}
