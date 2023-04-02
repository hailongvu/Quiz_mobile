// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lesson_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LessonDetail _$LessonDetailFromJson(Map<String, dynamic> json) => LessonDetail(
      id: json['id'] as int,
      term: json['term'] as String,
      definition: json['definition'] as String,
      image: json['image'],
      audio: json['audio'],
      video: json['video'],
      status: json['status'] as String,
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
    );

Map<String, dynamic> _$LessonDetailToJson(LessonDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'term': instance.term,
      'definition': instance.definition,
      'image': instance.image,
      'audio': instance.audio,
      'video': instance.video,
      'status': instance.status,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
