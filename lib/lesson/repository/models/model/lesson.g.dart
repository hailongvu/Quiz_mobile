// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lesson.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Lesson _$LessonFromJson(Map<String, dynamic> json) => Lesson(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      userId: json['user_id'] as int,
      status: json['status'] as String,
      isPublic: json['is_public'] as bool,
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
    );

Map<String, dynamic> _$LessonToJson(Lesson instance) => <String, dynamic>{
      'user_id': instance.userId,
      'is_public': instance.isPublic,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'status': instance.status,
    };
