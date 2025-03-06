import 'package:floor/floor.dart';

@Entity(tableName: 'todos')
class TodoDAO {
  @PrimaryKey(autoGenerate: false)
  final String id;
  final String title;
  final bool completed;
  TodoDAO({required this.id, required this.title, required this.completed});
}

@dao
abstract class TodoDao {
  @Query('SELECT * FROM todos')
  Future<List<TodoDAO>> getAllTodos();
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertTodos(List<TodoDAO> todos);
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertTodo(TodoDAO todo);
  @Query('UPDATE todos SET completed = :completed WHERE id = :id')
  Future<void> updateTodo(String id, bool completed);
  @Query('DELETE FROM todos WHERE id= :id')
  Future<void> deleteTodo(String id);
}
