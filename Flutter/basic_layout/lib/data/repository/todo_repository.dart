import 'package:basic_layout/data/datasources/todo_data_source.dart';
import 'package:basic_layout/data/models/todo_model.dart';

abstract class TodoRepositoryInterface {
  List<ToDo> fetchAll();

  void addTodo();
  void deleteTodo(int id);
  void updateTodo(int id);
}

class TodoRepositoryImpl implements TodoRepositoryInterface {
  final TodoDataSource todoDataSource = TodoDataSource();
  late final List<ToDo> _todo = todoDataSource.getTodoDataSource();
  @override
  List<ToDo> fetchAll() => _todo;

  @override
  void addTodo({
    String title = '',
    String description = '',
    String time = '',
    bool done = false,
  }) {
    _todo.add(ToDo(title, description, time, done, _todo.last.id + 1));
  }

  @override
  void deleteTodo(int id) {
    _todo.removeWhere((item) => item.id == id);
  }

  @override
  void updateTodo(int id) {
    int index = _todo.indexWhere((todo) => todo.id == id);
    _todo[index].done = !_todo[index].done;
  }
}
