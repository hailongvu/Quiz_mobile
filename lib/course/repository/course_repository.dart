import 'dart:convert';

import 'package:let_learn/base/repository/base_api_response.dart';
import 'package:let_learn/course/repository/course_api_client.dart';
import 'package:let_learn/course/repository/models/create/course_create.dart';
import 'package:let_learn/course/repository/models/model/course.dart';
import 'package:let_learn/course/repository/models/model/data_course.dart';

class CourseRepository {
  final courseClient = CourseAPIClient();

  Future<CourseResponse> createNewCourse(Course course) async {
    CourseCreate courseCreate = CourseCreate(
      name: course.name,
      description: course.description,
    );
    CourseResponse response = await courseClient.createNewCourse(courseCreate);
    return response;
  }

  Future<CourseResponse> getCourse(int idCourse) async {
    CourseResponse response = await courseClient.getCourse(idCourse);
    if (response.responseState == ResponseStatus.success) {
      if (response.data is String) {
        String dataString = response.data as String;
        if (dataString.isNotEmpty && dataString.contains('data')) {
          var data = jsonDecode(dataString);
          var jData = data['data'];
          var dataCourse = DataCourse.fromJson(jData);
          return CourseResponse.successWithData(
              response.responseState, dataCourse);
        }
      }
    }
    return response;
  }
}
