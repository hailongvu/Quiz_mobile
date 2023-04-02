import 'dart:convert';
import 'dart:developer';
import 'package:let_learn/base/repository/base_api_client.dart';
import 'package:let_learn/base/repository/base_api_response.dart';
import 'package:let_learn/course/repository/models/create/course_create.dart';

class CourseAPIClient extends BaseAPIClient {
  Future<CourseResponse> createNewCourse(CourseCreate courseCreate) async {
    Map<String, String> header = await getHeader();
    var body = jsonEncode(courseCreate);
    log('Create New Course $courseUrl');
    log('Create New Course $header');
    log('Create New Course $body');
    final response =
        await httpClient.post(courseUrl, headers: header, body: body);
    log('Create new course code ${response.statusCode}');
    switch (response.statusCode) {
      case 200:
        {
          return CourseResponse.success(ResponseStatus.success);
        }
      case 500:
        {
          return CourseResponse.error(
              ResponseStatus.error, "Server error is ${response.statusCode}");
        }
      default:
        {
          String messageBody = response.body;
          String message = messageBody;
          if (messageBody.contains("message")) {
            message = jsonDecode(messageBody)["message"];
          }
          return CourseResponse.error(ResponseStatus.error, message);
        }
    }
  }

  Future<CourseResponse> getCourse(int id) async {
    Map<String, String> header = await getHeader();
    log('getCourse header ${urlAccessCourseWithId(id)}');
    final response =
        await httpClient.get(urlAccessCourseWithId(id), headers: header);
    log('getCourse header response code ${response.statusCode}');
    switch (response.statusCode) {
      case 200:
        {
          return CourseResponse.successWithData(
              ResponseStatus.success, response.body);
        }
      case 500:
        {
          return CourseResponse.error(
              ResponseStatus.error, "Server error is ${response.statusCode}");
        }
      default:
        {
          String messageBody = response.body;
          String message = messageBody;
          if (messageBody.contains("message")) {
            message = jsonDecode(messageBody)["message"];
          }
          return CourseResponse.error(ResponseStatus.error, message);
        }
    }
  }
}
