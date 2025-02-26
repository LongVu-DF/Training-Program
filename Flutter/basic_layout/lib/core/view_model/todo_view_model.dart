import 'package:basic_layout/core/blocs/todo_bloc.dart';
import 'package:basic_layout/data/models/todo_model.dart';
import 'package:flutter/widgets.dart';

class ToDoViewModel with ChangeNotifier {
  final TodoBloc todoBloc;
  ToDoViewModel(this.todoBloc);
  List<ToDo> get todo => todoBloc.state.todo;

  void deleteTodo(int id) {
    todoBloc.deleteTodo(id);
  }

  void addTodo({
    String title = '',
    String description = '',
    String time = '',
    bool done = false,
  }) {
    todoBloc.addTodo(
      title: title,
      time: time,
      description: description,
      done: done,
    );
  }

  void updateTodo(int id) {
    todoBloc.updateTodo(id);
  }
}
