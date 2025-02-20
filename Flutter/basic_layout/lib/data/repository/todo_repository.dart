import 'package:basic_layout/data/models/todo_model.dart';

class TodoRepository {
  final List<ToDo> _todo = [
    ToDo('item 1', 'description 1', 'time 1', false),
    ToDo('item 2', 'description 2', 'time 2', false),
    ToDo('item 3', 'description 3', 'time 3', false),
    ToDo('item 4', 'description 4', 'time 4', false),
    ToDo('item 5', 'description 5', 'time 5', false),
  ];

  List<ToDo> get todo => _todo.where((todo) => todo.done == false).toList();
  List<ToDo> get done => _todo.where((todo) => todo.done == true).toList();

  List<ToDo> fetchToDo() {
    return todo;
  }

  List<ToDo> fetchDone() {
    return done;
  }

  void addTodo(ToDo todo) {
    _todo.add(todo);
  }
}
