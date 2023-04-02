import 'package:json_annotation/json_annotation.dart';

import '../edit/lesson_details_edit.dart';

part 'lesson_create.g.dart';

@JsonSerializable(explicitToJson: true)
class LessonCreate {
  late String name;

  late String description;

  late String password;

  @JsonKey(name: 'data')
  late List<LessonEditDetail> lessonEditDetailList;

  LessonCreate({
    required this.name,
    required this.description,
    required this.password,
    required this.lessonEditDetailList,
  });

  factory LessonCreate.fromJson(Map<String, dynamic> json) =>
      _$LessonCreateFromJson(json);

  Map<String, dynamic> toJson() => _$LessonCreateToJson(this);
}
