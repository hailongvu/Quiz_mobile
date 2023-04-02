import 'package:equatable/equatable.dart';

import '../../repository/models/model/course.dart';

abstract class CourseEvent extends Equatable {
  const CourseEvent();

  @override
  List<Object> get props => [];
}

class CreateCourse extends CourseEvent {
  final Course course;

  const CreateCourse({required this.course});

  @override
  List<Object> get props => [course];
}

class LoadDataCourseList extends CourseEvent {}

class UpdateDataCourse extends CourseEvent {
  final int idCourse;
  final String nameCourse;
  final String descriptionCourse;
  final String statusCourse;

  const UpdateDataCourse(
      {required this.idCourse,
      required this.nameCourse,
      required this.descriptionCourse,
      required this.statusCourse});

  @override
  List<Object> get props =>
      [idCourse, nameCourse, descriptionCourse, statusCourse];
}

class RemoveCourse extends CourseEvent {
  final int idCourse;

  const RemoveCourse({required this.idCourse});

  @override
  List<Object> get props => [idCourse];
}

class LoadDataCourseDetails extends CourseEvent {
  final int idCourse;

  const LoadDataCourseDetails(this.idCourse);

  @override
  List<Object> get props => [idCourse];
}
