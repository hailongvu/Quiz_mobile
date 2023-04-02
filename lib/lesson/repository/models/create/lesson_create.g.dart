// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lesson_create.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LessonCreate _$LessonCreateFromJson(Map<String, dynamic> json) => LessonCreate(
      name: json['name'] as String,
      description: json['description'] as String,
      password: json['password'] as String,
      lessonEditDetailList: (json['data'] as List<dynamic>)
          .map((e) => LessonEditDetail.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LessonCreateToJson(LessonCreate instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'password': instance.password,
      'data': instance.lessonEditDetailList.map((e) => e.toJson()).toList(),
    };
