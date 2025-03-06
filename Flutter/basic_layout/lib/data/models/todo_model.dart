import 'package:basic_layout/domain/entities/todo.dart';

class TodoModel extends Todo {
  // TodoModel({
  //   required String title,
  //   required String description,
  //   required String time,
  //   required bool done,
  //   required int id,
  // }) : super(
  //        title: title,
  //        description: description,
  //        time: time,
  //        done: done,
  //        id: id,
  //      );
  TodoModel({
    required super.title,
    required super.description,
    required super.time,
    required super.done,
    required super.id,
  });
  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      time: json['time'] ?? '',
      done: json['done'] ?? false,
      id: json['id'] ?? 0,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'time': time,
      'done': done,
      'id': id,
    };
  }

  @override
  String toString() {
    return 'ToDo(title: $title,description: $description, time: $time, done: $done, id: $id)';
  }
}
