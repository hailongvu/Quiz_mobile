import 'package:equatable/equatable.dart';

import '../../repository/models/details/lesson_details.dart';
import '../../repository/models/model/lesson.dart';

abstract class LessonEvent extends Equatable {
  const LessonEvent();

  @override
  List<Object> get props => [];
}

class LoadDataLessonDetails extends LessonEvent {
  final int idLesson;

  const LoadDataLessonDetails(this.idLesson);

  @override
  List<Object> get props => [idLesson];
}

class LoadDataLessonList extends LessonEvent {}

class UpdateDataLesson extends LessonEvent {
  final int idLesson;
  final String nameLesson;
  final String descriptionLesson;
  final String statusLesson;
  final List<LessonDetail> lessonDetailsList;

  const UpdateDataLesson(
      {required this.idLesson,
      required this.nameLesson,
      required this.descriptionLesson,
      required this.statusLesson,
      required this.lessonDetailsList});

  @override
  List<Object> get props =>
      [idLesson, nameLesson, descriptionLesson, statusLesson, lessonDetailsList];
}

class CreateDataLesson extends LessonEvent {
  final Lesson lesson;
  final List<LessonDetail> lessonDetails;

  const CreateDataLesson({required this.lesson, required this.lessonDetails});

  @override
  List<Object> get props => [lesson, lessonDetails];
}

class AddLessonDetail extends LessonEvent {
  final int id;
  final String term;
  final String definition;
  final List<LessonDetail> lessonDetailsList;

  const AddLessonDetail(
      {required this.id,
      required this.term,
      required this.definition,
      required this.lessonDetailsList});

  @override
  List<Object> get props => [id, term, definition, lessonDetailsList];
}

class RemoveLessonDetail extends LessonEvent {
  final int idLessonDetail;
  final List<LessonDetail> lessonDetailsList;

  const RemoveLessonDetail(
      {required this.idLessonDetail, required this.lessonDetailsList});

  @override
  List<Object> get props => [idLessonDetail, lessonDetailsList];
}

class RemoveLesson extends LessonEvent {
  final int idLessonDetail;

  const RemoveLesson({required this.idLessonDetail});

  @override
  List<Object> get props => [idLessonDetail];
}
