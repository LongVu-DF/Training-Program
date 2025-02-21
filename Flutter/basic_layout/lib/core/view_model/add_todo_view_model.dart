import 'package:basic_layout/data/repository/todo_repository.dart';

class AddTodoViewModel {
  final TodoRepository _todoRepository = TodoRepository();

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
    // notifyListeners();
  }
}
