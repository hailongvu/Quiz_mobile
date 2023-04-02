// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_lesson.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataLesson _$DataLessonFromJson(Map<String, dynamic> json) => DataLesson(
      Lesson.fromJson(json['lesson'] as Map<String, dynamic>),
      (json['detail'] as List<dynamic>)
          .map((e) => LessonDetail.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DataLessonToJson(DataLesson instance) =>
    <String, dynamic>{
      'lesson': instance.lesson.toJson(),
      'detail': instance.detailsList.map((e) => e.toJson()).toList(),
    };
