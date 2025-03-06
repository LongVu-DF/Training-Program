import 'package:basic_layout/data/datasources/remote/api_service.dart';
import 'package:basic_layout/data/models/dao/todo_dao.dart';
import 'package:basic_layout/data/models/mapper/todo_mapper.dart';
import 'package:basic_layout/domain/entities/todo.dart';
import 'package:basic_layout/domain/repositories/todo_repositories.dart';
import 'package:sqflite_common/sqlite_api.dart';

class TodoRepositoryImpl implements TodoRepository {
  // final TodoDataSource todoDataSource;
  final ApiService apiService;
  final TodoDao todoDao;
  TodoRepositoryImpl({required this.apiService, required this.todoDao});

  @override
  Future<List<Todo>> fetchAll() async {
    final todoDTOs = await apiService.getTodo();
    final todos = todoDTOs.map((dto) => TodoMapper.dtoToEntity(dto)).toList();
    await todoDao.insertTodos(
      todos.map((dao) => TodoMapper.entityToDAO(dao)).toList(),
    );

    return todos;
  }

  @override
  Future<void> addTodo(Todo todo) async {
    final todoDAO = TodoMapper.entityToDAO(todo);
    await apiService.addTodo(TodoMapper.entityToDTO(todo));
    await todoDao.insertTodo(todoDAO);
  }

  @override
  Future<void> deleteTodo(String id) async {
    await apiService.deleteTodo(id);
    await todoDao.deleteTodo(id);
  }

  @override
  Future<void> hasDoneTodo(String id, bool done) async {
    await apiService.hasDoneTodo(id, {"completed": done});
    await todoDao.updateTodo(id, done);
  }
}
