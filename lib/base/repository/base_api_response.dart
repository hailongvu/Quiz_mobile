import 'package:let_learn/lesson/repository/models/model/data_lesson.dart';

enum ResponseStatus { idle, error, success }

class LessonResponse {
  final ResponseStatus responseState;
  final String errorMessage;
  final data;

  const LessonResponse._(
      {this.responseState = ResponseStatus.idle,
      this.errorMessage = "",
      this.data});

  const LessonResponse.success(ResponseStatus responseState)
      : this._(responseState: responseState);

  const LessonResponse.successWithData(ResponseStatus responseState, data)
      : this._(responseState: responseState, data: data);

  const LessonResponse.error(ResponseStatus responseState, String errorMessage)
      : this._(responseState: responseState, errorMessage: errorMessage);
}

class CourseResponse {
  final ResponseStatus responseState;
  final String errorMessage;
  final data;

  const CourseResponse._(
      {this.responseState = ResponseStatus.idle,
      this.errorMessage = "",
      this.data});

  const CourseResponse.success(ResponseStatus responseState)
      : this._(responseState: responseState);

  const CourseResponse.error(ResponseStatus responseState, String errorMessage)
      : this._(responseState: responseState, errorMessage: errorMessage);

  const CourseResponse.successWithData(ResponseStatus responseState, data)
      : this._(responseState: responseState, data: data);
}
