import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'lesson.g.dart';

@JsonSerializable()
class Lesson extends Equatable {
  @JsonKey(name: 'user_id')
  final int userId;

  @JsonKey(name: 'is_public')
  final bool isPublic;

  @JsonKey(name: 'created_at')
  final String createdAt;

  @JsonKey(name: 'updated_at')
  final String updatedAt;

  final int id;

  final String name;

  final String description;

  final String status;

  const Lesson(
      {required this.id,
      required this.name,
      required this.description,
      required this.userId,
      required this.status,
      required this.isPublic,
      required this.createdAt,
      required this.updatedAt});

  static const empty = Lesson(
      id: 0,
      name: "",
      description: "",
      userId: 0,
      status: "",
      isPublic: false,
      createdAt: "",
      updatedAt: "");

  factory Lesson.fromJson(Map<String, dynamic> json) => _$LessonFromJson(json);

  Map<String, dynamic> toJson() => _$LessonToJson(this);

  @override
  String toString() {
    return 'Lesson(id: $id, name: $name, description: $description, userId: $userId, '
        'status: $status, isPublic: $isPublic, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  List<Object?> get props =>
      [id, name, description, userId, status, isPublic, createdAt, updatedAt];
}
