import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:let_learn/base/repository/base_api_response.dart';
import 'package:let_learn/course/bloc/event/course_event.dart';
import 'package:let_learn/course/bloc/states/course_state.dart';
import 'package:let_learn/course/repository/course_repository.dart';

class CourseBloc extends Bloc<CourseEvent, CourseState> {
  CourseBloc({
    required CourseRepository courseRepository,
  })  : _courseRepository = courseRepository,
        super(const CourseState.unknown()) {
    on<CreateCourse>(_onCreateDataCourse);
    on<LoadDataCourseDetails>(_onLoadDataCourse);
  }
  final CourseRepository _courseRepository;

  void _onCreateDataCourse(
      CreateCourse event, Emitter<CourseState> state) async {
    await _courseRepository.createNewCourse(event.course).then((value) {
      if (value.responseState == ResponseStatus.error) {
        emit(CourseState.error(value.errorMessage));
      } else {
        emit(const CourseState.created(CourseStatus.created));
      }
    });
  }

  void _onLoadDataCourse(
      LoadDataCourseDetails event, Emitter<CourseState> state) async {
    int idCourse = event.idCourse;
    await _courseRepository.getCourse(idCourse).then((value) {
      if (value.responseState == ResponseStatus.error) {
        emit(CourseState.error(value.errorMessage));
      } else {
        emit(CourseState.loaded(CourseStatus.success, value.data));
      }
    });
  }
}
