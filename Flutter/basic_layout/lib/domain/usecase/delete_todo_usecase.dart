import 'package:basic_layout/domain/repositories/todo_repositories.dart';

class DeleteTodoUsecase {
  final TodoRepository todoRepository;
  DeleteTodoUsecase(this.todoRepository);
  Future<void> execute(String id) async {
    return await todoRepository.deleteTodo(id);
  }
}
