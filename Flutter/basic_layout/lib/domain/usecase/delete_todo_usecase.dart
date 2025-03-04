import 'package:basic_layout/domain/repositories/todo_repositories.dart';

class DeleteTodoUsecase {
  final TodoRepository todoRepository;
  DeleteTodoUsecase(this.todoRepository);
  void execute(int id) {
    return todoRepository.deleteTodo(id);
  }
}
