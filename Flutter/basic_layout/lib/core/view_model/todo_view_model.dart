import 'package:basic_layout/data/models/todo_model.dart';
import 'package:basic_layout/data/repository/todo_repository.dart';

class ToDoViewModel {
  final TodoRepository _todoRepository = TodoRepository();
  // final List<ToDo> _todo;

  List<ToDo> get todo => _todoRepository.fetchToDo();
  void addToDo({
    String title = '',
    String description = '',
    String time = '',
    bool done = false,
  }) {
    _todoRepository.addTodo(ToDo(title, description, time, done));
  }

  // void deleteToDo()
}
