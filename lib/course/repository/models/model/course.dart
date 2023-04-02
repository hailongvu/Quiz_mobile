import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'course.g.dart';

@JsonSerializable()
class Course extends Equatable {
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

  const Course(
      {required this.id,
      required this.name,
      required this.description,
      required this.userId,
      required this.status,
      required this.isPublic,
      required this.createdAt,
      required this.updatedAt});

  static const empty = Course(
      id: 0,
      name: "",
      description: "",
      userId: 0,
      status: "",
      isPublic: false,
      createdAt: "",
      updatedAt: "");

  factory Course.fromJson(Map<String, dynamic> json) => _$CourseFromJson(json);

  Map<String, dynamic> toJson() => _$CourseToJson(this);
  @override
  String toString() {
    return 'Course(id: $id, name: $name, description: $description, userId: $userId, status: $status, isPublic: $isPublic, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  List<Object?> get props =>
      [id, name, description, userId, status, isPublic, createdAt, updatedAt];
}
