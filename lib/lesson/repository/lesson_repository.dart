import 'dart:convert';
import 'dart:developer';
import 'package:let_learn/base/repository/base_api_response.dart';
import 'package:let_learn/lesson/repository/lesson_api_client.dart';

import 'models/create/lesson_create.dart';
import 'models/details/lesson_details.dart';
import 'models/edit/lesson_details_edit.dart';
import 'models/edit/lesson_edit.dart';
import 'models/model/data_lesson.dart';
import 'models/model/lesson.dart';

class LessonRepository {
  final lessonClient = LessonAPIClient();

  Future<LessonResponse> createNewLesson(Lesson lesson, List<LessonDetail> list) async {
    List<LessonEditDetail> lessonCreateDetail = [];
    for (var value in list) {
      lessonCreateDetail.add(
          LessonEditDetail(term: value.term, definition: value.definition));
    }
    LessonCreate lessonCreate = LessonCreate(
        name: lesson.name,
        description: lesson.description,
        password: "",
        lessonEditDetailList: lessonCreateDetail);

    LessonResponse response = await lessonClient.createNewLesson(lessonCreate);
    return response;
  }

  Future<LessonResponse> getLessonDetails(int idLesson) async {
    LessonResponse response = await lessonClient.getLesson(idLesson);
    if (response.responseState == ResponseStatus.success) {
      if (response.data is String) {
        String dataString = response.data as String;
        if (dataString.isNotEmpty && dataString.contains('data')) {
          var data = jsonDecode(dataString);
          var jData = data['data'];
          var dataLesson = DataLesson.fromJson(jData);
          return LessonResponse.successWithData(
              response.responseState, dataLesson);
        }
      }
    }
    return response;
  }

  Future<LessonResponse> updateLesson(int idLesson, String nameLesson, String descriptionLesson,
      String statusLesson, List<LessonDetail> lessonDetailsList) async {
    List<LessonEditDetail> lessonEditDetailsList = [];
    for (var element in lessonDetailsList) {
      lessonEditDetailsList.add(
          LessonEditDetail(term: element.term, definition: element.definition));
    }
    var lessonEdit = LessonEdit(
        name: nameLesson,
        description: descriptionLesson,
        status: statusLesson,
        isPublic: 1,
        password: "",
        lessonEditDetailList: lessonEditDetailsList);

    LessonResponse response = await lessonClient.updateLesson(idLesson, lessonEdit);
    return response;
  }

  Future<LessonResponse> removeLesson(int idLessonDetailRemove) async {
    LessonResponse response = await lessonClient.removeLesson(idLessonDetailRemove);
    return response;
  }

  addLessonDetails(int id, String term, String definition,
      List<LessonDetail> lessonDetailsList) async {
    var lessonDetail = LessonDetail(
        id: id,
        term: term,
        definition: definition,
        status: "",
        createdAt: "",
        updatedAt: "");
    lessonDetailsList.add(lessonDetail);
    return lessonDetailsList;
  }

  removeLessonDetails(
      int idLessonDetailRemove, List<LessonDetail> lessonDetailsList) async {
    if (lessonDetailsList.length <= 1) {
      lessonDetailsList.clear();
      return lessonDetailsList;
    }
    var newList =
        lessonDetailsList.where((x) => x.id != idLessonDetailRemove).toList();
    return newList;
  }
}
