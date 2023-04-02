import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'lesson_details.g.dart';

@JsonSerializable()
class LessonDetail extends Equatable {
  int id;
  String term;
  String definition;
  dynamic image;
  dynamic audio;
  dynamic video;
  String status;

  LessonDetail({
    required this.id,
    required this.term,
    required this.definition,
    this.image,
    this.audio,
    this.video,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  @JsonKey(name: 'created_at')
  String createdAt;

  @JsonKey(name: 'updated_at')
  String updatedAt;

  factory LessonDetail.fromJson(Map<String, dynamic> json) => _$LessonDetailFromJson(json);

  Map<String, dynamic> toJson() => _$LessonDetailToJson(this);

  @override
  String toString() {
    return 'LessonDetail(id: $id, term: $term, definition: $definition, image: $image, audio: $audio, video: $video, status: $status, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
