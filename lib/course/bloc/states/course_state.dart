import 'package:let_learn/course/repository/models/model/data_course.dart';

enum CourseStatus {
  unknown,
  loaded,
  added,
  removed,
  details,
  updated,
  created,
  error,
  success
}

class CourseState {
  final CourseStatus status;
  final String errorMessage;
  final data;
  final List<DataCourse> dataCourseList;

  const CourseState._({
    this.dataCourseList = const [],
    this.status = CourseStatus.unknown,
    this.errorMessage = "",
    this.data,
  });

  const CourseState.unknown() : this._();

  const CourseState.loaded(CourseStatus status, data)
      : this._(status: status, data: data);

  const CourseState.updated(CourseStatus status) : this._(status: status);

  const CourseState.created(CourseStatus status) : this._(status: status);

  const CourseState.removedCourse(CourseStatus status) : this._(status: status);

  const CourseState.error(String errorMessage)
      : this._(status: CourseStatus.error, errorMessage: errorMessage);
}
