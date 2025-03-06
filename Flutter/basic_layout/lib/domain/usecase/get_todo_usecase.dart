import 'package:basic_layout/domain/entities/todo.dart';
import 'package:basic_layout/domain/repositories/todo_repositories.dart';

class GetTodoUseCase {
  final TodoRepository todoRepository;
  GetTodoUseCase(this.todoRepository);
  List<Todo> execute() {
    return todoRepository.fetchAll();
  }
}
