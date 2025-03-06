import 'package:basic_layout/domain/repositories/todo_repositories.dart';

class HasDoneTodoUsecase {
  final TodoRepository todoRepository;
  HasDoneTodoUsecase(this.todoRepository);
  void execute(int id, bool done) {
    return todoRepository.hasDoneTodo(id, done);
  }
}
