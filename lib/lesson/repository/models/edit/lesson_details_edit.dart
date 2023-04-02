import 'package:json_annotation/json_annotation.dart';

part 'lesson_details_edit.g.dart';

@JsonSerializable()
class LessonEditDetail {
  late String term;
  late String definition;

  LessonEditDetail({required this.term, required this.definition});

  factory LessonEditDetail.fromJson(Map<String, dynamic> json) =>
      _$LessonEditDetailFromJson(json);

  Map<String, dynamic> toJson() => _$LessonEditDetailToJson(this);
}
