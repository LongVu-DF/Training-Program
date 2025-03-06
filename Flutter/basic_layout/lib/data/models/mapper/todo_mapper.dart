import 'package:basic_layout/data/models/dao/todo_dao.dart';
import 'package:basic_layout/data/models/dto/todo_dto.dart';
import 'package:basic_layout/domain/entities/todo.dart';

class TodoMapper {
  // DTO -> Entities (data from api)
  static Todo dtoToEntity(TodoDto dto) {
    return Todo(
      title: dto.title,
      description: dto.description,
      time: dto.time,
      done: dto.completed,
      id: dto.id,
    );
  }

  // Entities -> DTO (send data to API)
  static TodoDto entityToDTO(Todo todo) {
    return TodoDto(
      id: todo.id,
      title: todo.title,
      completed: todo.done,
      time: todo.time,
      description: todo.description,
    );
  }

  // DAO -> Entities (data from local store)
  static Todo daoToEntity(TodoDAO dao) {
    return Todo(
      title: dao.id,
      description: dao.title,
      time: DateTime.timestamp().second,
      done: dao.completed,
      id: dao.id,
    );
  }

  static TodoDAO entityToDAO(Todo todo) {
    return TodoDAO(title: todo.title, completed: todo.done, id: todo.id);
  }
}
