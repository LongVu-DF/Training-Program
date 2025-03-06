import 'package:basic_layout/data/datasources/todo_data_source.dart';
import 'package:basic_layout/data/models/todo_model.dart';
import 'package:basic_layout/domain/entities/todo.dart';
import 'package:basic_layout/domain/repositories/todo_repositories.dart';

class TodoRepositoryImpl implements TodoRepository {
  final TodoDataSource todoDataSource;
  TodoRepositoryImpl(this.todoDataSource);

  @override
  List<TodoModel> fetchAll() => todoDataSource.getTodoDataSource();

  @override
  void addTodo(Todo todo) {
    todoDataSource.addTodo(
      TodoModel(
        title: todo.title,
        description: todo.description,
        time: todo.time,
        done: todo.done,
        id: todo.id,
      ),
    );
    // print(_todo.toString());
  }

  @override
  void deleteTodo(int id) {
    todoDataSource.deleteTodo(id);
  }

  @override
  void hasDoneTodo(int id, bool done) {
    todoDataSource.hasDoneTodo(id, done);
  }
}
