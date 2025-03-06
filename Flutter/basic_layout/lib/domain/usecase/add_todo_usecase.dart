import 'package:basic_layout/domain/entities/todo.dart';
import 'package:basic_layout/domain/repositories/todo_repositories.dart';

class AddTodoUsecase {
  final TodoRepository todoRepository;
  AddTodoUsecase(this.todoRepository);
  Future<void> execute(Todo todo) async {
    return await todoRepository.addTodo(todo);
  }
}
