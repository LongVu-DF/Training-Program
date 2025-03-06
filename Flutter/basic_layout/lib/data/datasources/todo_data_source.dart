import 'package:basic_layout/data/models/todo_model.dart';

class TodoDataSource {
  static final TodoDataSource _instance = TodoDataSource._internal();
  factory TodoDataSource() => _instance;
  TodoDataSource._internal();
  final List<TodoModel> _todo = [
    TodoModel(
      title: 'item 1',
      description: 'description 1',
      time: 'time 1',
      done: false,
      id: 1,
    ),
    TodoModel(
      title: 'item 2',
      description: 'description 2',
      time: 'time 2',
      done: false,
      id: 2,
    ),
    TodoModel(
      title: 'item 3',
      description: 'description 3',
      time: 'time 3',
      done: true,
      id: 3,
    ),
    TodoModel(
      title: 'item 4',
      description: 'description 4',
      time: 'time 4',
      done: false,
      id: 4,
    ),
    TodoModel(
      title: 'item 5',
      description: 'description 5',
      time: 'time 5',
      done: false,
      id: 5,
    ),
  ];
  List<TodoModel> getTodoDataSource() {
    return _todo;
  }

  void addTodo(TodoModel todo) {
    _todo.add(todo);
  }

  void deleteTodo(int id) {
    _todo.removeWhere((item) => item.id == id);
  }

  void hasDoneTodo(int id, bool done) {
    int index = _todo.indexWhere((todo) => todo.id == id);
    if (index != -1) {
      _todo[index] = TodoModel(
        title: _todo[index].title,
        description: _todo[index].description,
        time: _todo[index].time,
        done: done,
        id: _todo[index].id,
      );
    }
  }
}
