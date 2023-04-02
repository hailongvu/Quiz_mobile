// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lesson_edit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LessonEdit _$LessonEditFromJson(Map<String, dynamic> json) => LessonEdit(
      name: json['name'] as String,
      description: json['description'] as String,
      status: json['status'] as String,
      isPublic: json['is_public'] as int,
      password: json['password'] as String,
      lessonEditDetailList: (json['data'] as List<dynamic>)
          .map((e) => LessonEditDetail.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LessonEditToJson(LessonEdit instance) =>
    <String, dynamic>{
      'is_public': instance.isPublic,
      'name': instance.name,
      'description': instance.description,
      'status': instance.status,
      'password': instance.password,
      'data': instance.lessonEditDetailList.map((e) => e.toJson()).toList(),
    };
