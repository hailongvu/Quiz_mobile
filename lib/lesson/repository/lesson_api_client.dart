import 'dart:convert';
import 'dart:developer';
import '../../base/repository/base_api_client.dart';
import '../../base/repository/base_api_response.dart';
import 'models/create/lesson_create.dart';
import 'models/edit/lesson_edit.dart';

class LessonAPIClient extends BaseAPIClient {
  Future<LessonResponse> createNewLesson(LessonCreate lessonCreate) async {
    Map<String, String> header = await getHeader();
    var body = jsonEncode(lessonCreate);
    log('Create New Lesson $addUrl');
    log('Create New Lesson $header');
    log('Create New Lesson $body');
    final response = await httpClient.post(addUrl, headers: header, body: body);
    log('Create new lesson code ${response.statusCode}');
    switch (response.statusCode) {
      case 200:
        {
          return LessonResponse.success(ResponseStatus.success);
        }
      case 500:
        {
          return LessonResponse.error(
              ResponseStatus.error, "Server error is ${response.statusCode}");
        }
      default:
        {
          String messageBody = response.body;
          String message = messageBody;
          if (messageBody.contains("message")) {
            message = jsonDecode(messageBody)["message"];
          }
          return LessonResponse.error(ResponseStatus.error, message);
        }
    }
  }

  Future<LessonResponse> getLesson(int id) async {
    Map<String, String> header = await getHeader();
    log('getLesson header ${urlAccessLessonWithId(id)}');
    final response =
        await httpClient.get(urlAccessLessonWithId(id), headers: header);
    log('getLesson header response code ${response.statusCode}');
    switch (response.statusCode) {
      case 200:
        {
          return LessonResponse.successWithData(
              ResponseStatus.success, response.body);
        }
      case 500:
        {
          return LessonResponse.error(
              ResponseStatus.error, "Server error is ${response.statusCode}");
        }
      default:
        {
          String messageBody = response.body;
          String message = messageBody;
          if (messageBody.contains("message")) {
            message = jsonDecode(messageBody)["message"];
          }
          return LessonResponse.error(ResponseStatus.error, message);
        }
    }
  }

  Future<LessonResponse> updateLesson(int id, LessonEdit lessonEdit) async {
    Map<String, String> header = await getHeader();
    var link = urlAccessLessonWithId(id);
    var body = jsonEncode(lessonEdit);
    log('update lesson $id ---- $link');
    log('update lesson $id ---- $header');
    log('update lesson $id ---- $body');
    final response = await httpClient.put(urlAccessLessonWithId(id),
        headers: header, body: body);
    log('update lesson header response code ${response.statusCode}');
    switch (response.statusCode) {
      case 200:
        {
          return LessonResponse.success(ResponseStatus.success);
        }
      case 500:
        {
          return LessonResponse.error(
              ResponseStatus.error, "Server error is ${response.statusCode}");
        }
      default:
        {
          String messageBody = response.body;
          String message = messageBody;
          if (messageBody.contains("message")) {
            message = jsonDecode(messageBody)["message"];
          }
          return LessonResponse.error(ResponseStatus.error, message);
        }
    }
  }

  Future<LessonResponse> removeLesson(int id) async {
    Map<String, String> header = await getHeader();
    var link = urlAccessLessonWithId(id);
    log('remove link $id ---- $link');
    log('remove header $id ---- $header');
    final response = await httpClient.delete(link, headers: header);
    log('remove lesson response ${response.statusCode}');
    switch (response.statusCode) {
      case 200:
        {
          return LessonResponse.success(ResponseStatus.success);
        }
      case 500:
        {
          return LessonResponse.error(
              ResponseStatus.error, "Server error is ${response.statusCode}");
        }
      default:
        {
          String messageBody = response.body;
          String message = messageBody;
          if (messageBody.contains("message")) {
            message = jsonDecode(messageBody)["message"];
          }
          return LessonResponse.error(ResponseStatus.error, message);
        }
    }
  }
}
