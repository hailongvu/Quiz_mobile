import '../../repository/models/details/lesson_details.dart';
import '../../repository/models/model/data_lesson.dart';

enum LessonStatus {
  unknown,
  added,
  created,
  removed,
  updated,
  success,
  error
}

class LessonState {
  final DataLesson dataLesson;
  final List<DataLesson> dataLessonList;
  final List<LessonDetail> lessonDetailList;
  final LessonStatus status;
  final data;
  final String errorMessage;

  const LessonState._({
    this.status = LessonStatus.unknown,
    this.dataLesson = DataLesson.empty,
    this.lessonDetailList = const [],
    this.dataLessonList = const [],
    this.data,
    this.errorMessage = ""
  });

  const LessonState.unknown() : this._();

  const LessonState.loaded(LessonStatus status, data)
      : this._(status: status, data: data);

  const LessonState.updated(LessonStatus status)
      : this._(status: status);

  const LessonState.created(LessonStatus status)
      : this._(status: status);

  const LessonState.removedLesson(LessonStatus status)
      : this._(status: status);

  // ----
  const LessonState.addLessonDetail(List<LessonDetail> list)
      : this._(status: LessonStatus.added, lessonDetailList: list);

  const LessonState.removeLessonDetail(List<LessonDetail> list)
      : this._(status: LessonStatus.removed, lessonDetailList: list);

  const LessonState.error(String errorMessage) : this._(status: LessonStatus.error, errorMessage: errorMessage);
}
