import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../details/lesson_details.dart';
import 'lesson.dart';

part 'data_lesson.g.dart';

@JsonSerializable(explicitToJson: true)
class DataLesson extends Equatable {
  const DataLesson(this.lesson, this.detailsList);

  @JsonKey(name: 'lesson')
  final Lesson lesson;

  @JsonKey(name: 'detail')
  final List<LessonDetail> detailsList;

  factory DataLesson.fromJson(Map<String, dynamic> json) =>
      _$DataLessonFromJson(json);

  Map<String, dynamic> toJson() => _$DataLessonToJson(this);

  @override
  String toString() {
    return 'DataLesson(Lesson: $lesson, detail: $detailsList)';
  }

  @override
  List<Object?> get props => [lesson, detailsList];

  static const empty = DataLesson(Lesson.empty, []);
}
