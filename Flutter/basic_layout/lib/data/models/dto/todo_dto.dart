import 'package:json_annotation/json_annotation.dart';

part 'todo_dto.g.dart';

@JsonSerializable()
class TodoDto {
  final String id;
  final String title;
  final String description;
  final bool completed;
  final int time;
  TodoDto({
    required this.id,
    required this.title,
    required this.description,
    required this.completed,
    required this.time,
  });
  factory TodoDto.fromJson(Map<String, dynamic> json) =>
      _$TodoDtoFromJson(json);
  Map<String, dynamic> toJson() => _$TodoDtoToJson(this);
}
