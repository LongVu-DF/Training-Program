import 'package:basic_layout/data/models/todo_model.dart';
import 'package:basic_layout/data/repository/todo_repository.dart';
import 'package:flutter/widgets.dart';

class ToDoViewModel with ChangeNotifier {
  final TodoRepository _todoRepository = TodoRepository();

  List<ToDo> get todo => _todoRepository.fetchToDo();

  void deleteTodo(int id) {
    _todoRepository.deleteTodo(id);
    notifyListeners();
  }

  ToDoViewModel() {
    _todoRepository.addListener(() {
      notifyListeners();
    });
  }
}
