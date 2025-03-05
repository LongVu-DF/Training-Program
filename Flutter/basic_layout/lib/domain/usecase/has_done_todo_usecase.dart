import 'package:basic_layout/domain/repositories/todo_repositories.dart';

class HasDoneTodoUsecase {
  final TodoRepository todoRepository;
  HasDoneTodoUsecase(this.todoRepository);
  Future<void> execute(String id, bool done) async {
    return await todoRepository.hasDoneTodo(id, done);
  }
}
