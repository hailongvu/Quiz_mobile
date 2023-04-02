import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'course.dart';

part 'data_course.g.dart';

@JsonSerializable(explicitToJson: true)
class DataCourse extends Equatable {
  const DataCourse(this.course);

  @JsonKey(name: 'course')
  final Course course;

  factory DataCourse.fromJson(Map<String, dynamic> json) =>
      _$DataCourseFromJson(json);

  Map<String, dynamic> toJson() => _$DataCourseToJson(this);

  @override
  String toString() {
    return 'DataCourse(Course: $course)';
  }

  @override
  List<Object?> get props => [course];

  static const empty = DataCourse(Course.empty);
}