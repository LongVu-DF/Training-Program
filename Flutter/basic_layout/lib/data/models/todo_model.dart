class ToDo {
  String title;
  String description;
  String time;
  bool done;
  int id;
  ToDo(this.title, this.description, this.time, this.done, this.id);
  @override
  String toString() {
    return 'ToDo(title: $title,description: $description, time: $time, done: $done, id: $id)';
  }
}
