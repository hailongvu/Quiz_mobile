import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:let_learn/home/screen/add/screen_add.dart';
import 'package:let_learn/utils/Colors.dart';
import 'package:let_learn/lesson/bloc/lesson_bloc.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../../ui/popup_menu.dart';
import '../../../utils/Strings.dart';
import '../../bloc/event/lesson_event.dart';
import '../../bloc/states/lesson_state.dart';
import '../../repository/lesson_repository.dart';
import '../../repository/models/details/lesson_details.dart';
import '../../repository/models/model/data_lesson.dart';
import '../../repository/models/model/lesson.dart';
import '../screen_lesson_details_list.dart';

class ScreenEditLesson extends StatelessWidget {
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  var lessonDetailsList = <LessonDetail>[];
  DataLesson dataLesson;

  ScreenEditLesson({super.key, required this.dataLesson});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: signInBgColor,
      appBar: AppBar(
          title: const Text(headerEditSetPage),
          actions: [PopupMenu(idLesson: dataLesson.lesson.id)]),
      body: BlocProvider.value(
        value: LessonBloc(lessonRepository: LessonRepository()),
        child: BlocListener<LessonBloc, LessonState>(
          listener: (context, state) {
            log('sdfsdfsdfsf ${state.status}');
            handleStateResponse(state, context);
          },
          child: BlocBuilder<LessonBloc, LessonState>(
            builder: (context, state) {
              buildViews(state);
              return Column(
                children: [
                  Container(
                    margin: const EdgeInsets.all(10),
                    child: TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        hintText: 'Name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(10),
                    child: TextField(
                      controller: descriptionController,
                      decoration: InputDecoration(
                        hintText: 'Description',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  ScreenLessonDetailList(
                    lessonDetailsList: lessonDetailsList,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          right: 8,
                          bottom: 16,
                        ),
                        child: Column(
                          children: [
                            FloatingActionButton(
                              heroTag: "Add",
                              onPressed: () {
                                addLessonDetail(context);
                              },
                              child: const Icon(Icons.add),
                            ),
                            const SizedBox(height: 8),
                            FloatingActionButton(
                              heroTag: "Save",
                              onPressed: () {
                                requestSaveLesson(context);
                              },
                              child: const Icon(Icons.save),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  void addLessonDetail(BuildContext context) {
    context.read<LessonBloc>().add(AddLessonDetail(
        id: lessonDetailsList.length,
        term: "",
        definition: "",
        lessonDetailsList: lessonDetailsList));
  }

  void requestSaveLesson(BuildContext context) {
    Lesson lesson = dataLesson.lesson;
    onUpdateLesson(context, lesson.id, nameController.text,
        descriptionController.text, lesson.status);
  }

  void buildViews(LessonState state) {
    log("value--------------- ${state.status}");
    if (state.status == LessonStatus.unknown) {
      lessonDetailsList = dataLesson.detailsList;
      nameController.text = dataLesson.lesson.name;
      descriptionController.text = dataLesson.lesson.description;
    }
  }

  void handleStateResponse(LessonState state, BuildContext context) {
    if (state.status == LessonStatus.removed || state.status == LessonStatus.updated) {
      if (state.lessonDetailList.isEmpty && lessonDetailsList.isNotEmpty) {
        lessonDetailsList.clear();
      } else {
        lessonDetailsList = state.lessonDetailList;
      }
    }
    if (state.status == LessonStatus.error) {
      toast(state.errorMessage);
    }
    if (state.status == LessonStatus.updated || state.status == LessonStatus.success) {
      toast('Success');
      ScreenAdd().launch(isNewTask: true, context);
    }
    log('Edit screen state is ${state.status}');
  }

  void onUpdateLesson(BuildContext context, int idLesson, String nameLesson,
      String descriptionLesson, String statusLesson) {
    context.read<LessonBloc>().add(UpdateDataLesson(
        idLesson: idLesson,
        nameLesson: nameLesson,
        descriptionLesson: descriptionLesson,
        statusLesson: statusLesson,
        lessonDetailsList: lessonDetailsList));
  }
}
