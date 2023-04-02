


import 'package:json_annotation/json_annotation.dart';

part 'course_create.g.dart';

@JsonSerializable(explicitToJson: true)
class CourseCreate {
  late String name;
  late String description;

  CourseCreate({
    required this.name,
    required this.description,
  });

  factory CourseCreate.fromJson(Map<String, dynamic> json) =>
      _$CourseCreateFromJson(json);

  Map<String, dynamic> toJson() => _$CourseCreateToJson(this);

}