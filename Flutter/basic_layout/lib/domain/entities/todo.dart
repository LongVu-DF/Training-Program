class Todo {
  final String title;
  final String description;
  final int time;
  final bool done;
  final String id;
  Todo({
    required this.title,
    required this.description,
    required this.time,
    required this.done,
    required this.id,
  });
  Todo copyWith({
    String? id,
    String? title,
    bool? done,
    int? time,
    String? description,
  }) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      done: done ?? this.done,
      time: time ?? this.time,
      description: description ?? this.description,
    );
  }
}
