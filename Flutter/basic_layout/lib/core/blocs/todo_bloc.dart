import 'package:basic_layout/data/models/todo_model.dart';
import 'package:basic_layout/data/repository/todo_repository.dart';
import 'package:bloc/bloc.dart';

class TodoBloc extends Cubit<TodoState> {
  final TodoRepositoryImpl repositoryImpl;
  TodoBloc(this.repositoryImpl)
    : super(TodoState(todo: repositoryImpl.fetchAll()));

  void addTodo({
    String title = '',
    String description = '',
    String time = '',
    bool done = false,
  }) {
    repositoryImpl.addTodo(title: title, time: time, description: description);
    emit(TodoState(todo: repositoryImpl.fetchAll()));
  }

  void deleteTodo(int id) {
    repositoryImpl.deleteTodo(id);
    emit(TodoState(todo: repositoryImpl.fetchAll()));
  }

  void updateTodo(int id) {
    repositoryImpl.updateTodo(id);
    emit(TodoState(todo: repositoryImpl.fetchAll()));
  }
}

class TodoState {
  final List<ToDo> todo;
  const TodoState({required this.todo});
}
