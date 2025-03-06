import '../entities/todo.dart';

abstract class TodoRepository {
  List<Todo> fetchAll();

  void addTodo(Todo todo);
  void deleteTodo(int id);
  void hasDoneTodo(int id, bool done);
}
