import 'package:basic_layout/domain/entities/todo.dart';
import 'package:basic_layout/domain/repositories/todo_repositories.dart';

class AddTodoUsecase {
  final TodoRepository todoRepository;
  AddTodoUsecase(this.todoRepository);
  void execute(Todo todo) {
    return todoRepository.addTodo(todo);
  }
}
