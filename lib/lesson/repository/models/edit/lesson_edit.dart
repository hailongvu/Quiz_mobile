import 'package:json_annotation/json_annotation.dart';

import 'lesson_details_edit.dart';

part 'lesson_edit.g.dart';

@JsonSerializable(explicitToJson: true)
class LessonEdit {
  @JsonKey(name: 'is_public')
  late int isPublic;

  late String name;

  late String description;

  late String status;

  late String password;

  @JsonKey(name: 'data')
  late List<LessonEditDetail> lessonEditDetailList;

  LessonEdit({
    required this.name,
    required this.description,
    required this.status,
    required this.isPublic,
    required this.password,
    required this.lessonEditDetailList,
  });

  factory LessonEdit.fromJson(Map<String, dynamic> json) =>
      _$LessonEditFromJson(json);

  Map<String, dynamic> toJson() => _$LessonEditToJson(this);
}
