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

  Future<void> addTodo(Todo todo) async {
    if (state is TodoLoaded) {
      final currentState = state as TodoLoaded;
      final updateTodo = List<Todo>.from(currentState.todos)..add(todo);
      emit(TodoLoaded(updateTodo));
    }
    try {
      addTodoUsecase.execute(todo);
    } catch (e) {
      emit(TodoError(e.toString()));
    }
  }

  Future<void> deleteTodo(String id) async {
    if (state is TodoLoaded) {
      final currentState = state as TodoLoaded;
      final updateTodo =
          List<Todo>.from(
            currentState.todos,
          ).where((todo) => todo.id != id).toList();
      emit(TodoLoaded(updateTodo));
    }
    try {
      await deleteTodoUsecase.execute(id);
    } catch (e) {
      emit(TodoError(e.toString()));
    }
  }

  Future<void> hasDoneTodo(String id, bool done) async {
    if (state is TodoLoaded) {
      final currentState = state as TodoLoaded;
      final updateTodo =
          currentState.todos.map((todo) {
            return todo.id == id ? todo.copyWith(done: done) : todo;
          }).toList();
      emit(TodoLoaded(updateTodo));
    }
    try {
      await hasDoneTodoUsecase.execute(id, done);
    } catch (e) {
      emit(TodoError(e.toString()));
    }
  }
}
