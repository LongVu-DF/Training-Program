import '../entities/todo.dart';

abstract class TodoRepository {
  Future<List<Todo>> fetchAll();

  Future<void> addTodo(Todo todo);
  Future<void> deleteTodo(String id);
  Future<void> hasDoneTodo(String id, bool done);
}
