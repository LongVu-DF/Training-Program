import 'package:floor/floor.dart';

@Entity(tableName: 'todos')
class TodoDAO {
  @PrimaryKey(autoGenerate: true)
  final String id;
  final String title;
  final bool completed;
  TodoDAO({required this.id, required this.title, required this.completed});
}

@dao
abstract class TodoDao {
  @Query('SELECT * FROM todos')
  Future<List<TodoDAO>> getAllTodos();

  @insert
  Future<void> insertTodo(TodoDAO todo);
  @Query('UPDATE todos SET completed = :completed WHERE id = :id')
  Future<void> updateTodo(String id, bool completed);
  @Query('DELETE FROM todos WHERE id= :id')
  Future<void> deleteTodo(String id);
}
