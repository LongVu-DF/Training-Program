import 'package:basic_layout/domain/entities/todo.dart';
import 'package:basic_layout/domain/usecase/add_todo_usecase.dart';
import 'package:basic_layout/domain/usecase/delete_todo_usecase.dart';
import 'package:basic_layout/domain/usecase/get_todo_usecase.dart';
import 'package:basic_layout/domain/usecase/has_done_todo_usecase.dart';
import 'package:bloc/bloc.dart';
part 'package:basic_layout/presentation/blocs/todo_state.dart';

class TodoBloc extends Cubit<TodoState> {
  final GetTodoUseCase getTodoUseCase;
  final AddTodoUsecase addTodoUsecase;
  final HasDoneTodoUsecase hasDoneTodoUsecase;
  final DeleteTodoUsecase deleteTodoUsecase;
  TodoBloc({
    required this.getTodoUseCase,
    required this.addTodoUsecase,
    required this.hasDoneTodoUsecase,
    required this.deleteTodoUsecase,
  }) : super(TodoInitial()) {
    fetchTodo();
  }

  Future<void> fetchTodo() async {
    emit(TodoLoading());
    final todos = await getTodoUseCase.execute();
    emit(TodoLoaded(todos));
  }

  void addTodo(Todo todo) {
    addTodoUsecase.execute(todo);
    fetchTodo();
  }

  void deleteTodo(String id) {
    deleteTodoUsecase.execute(id);
    fetchTodo();
  }

  void hasDoneTodo(String id, bool done) {
    hasDoneTodoUsecase.execute(id, done);
    fetchTodo();
  }
}
