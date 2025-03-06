part of 'todo_bloc.dart';

abstract class TodoState {}

class TodoInitial extends TodoState {}

class TodoLoading extends TodoState {}

class TodoLoaded extends TodoState {
  final List<Todo> todos;

  TodoLoaded(this.todos);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is TodoLoaded && other.todos == todos;
  }

  @override
  int get hashCode => todos.hashCode;
}

class TodoError extends TodoState {
  final String message;

  TodoError(this.message);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is TodoError && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
