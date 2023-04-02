// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_course.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataCourse _$DataCourseFromJson(Map<String, dynamic> json) => DataCourse(
      Course.fromJson(json['course'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DataCourseToJson(DataCourse instance) =>
    <String, dynamic>{
      'course': instance.course.toJson(),
    };
