import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:let_learn/utils/Colors.dart';
import 'package:let_learn/lesson/bloc/lesson_bloc.dart';
import '../../bloc/event/lesson_event.dart';
import '../../bloc/states/lesson_state.dart';
import '../../repository/lesson_repository.dart';
import '../../repository/models/details/lesson_details.dart';
import '../../repository/models/model/lesson.dart';
import '../screen_lesson_details_list.dart';

class CreateLessonNew extends StatelessWidget {
  final termController = TextEditingController();
  final definitionController = TextEditingController();
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  var detailCount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: signInBgColor,
      appBar: AppBar(
        title: const Text('Create Lesson'),
      ),
      body: BlocProvider(
        create: (context) => LessonBloc(lessonRepository: LessonRepository()),
        child: BlocListener<LessonBloc, LessonState>(
          listener: (context, state) {},
          child: BlocBuilder<LessonBloc, LessonState>(
            builder: (context, state) {
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
                      lessonDetailsList: state.lessonDetailList),
                  FloatingActionButton(
                    onPressed: () {
                      _addLessonDetail(context);
                    },
                    child: const Icon(Icons.add),
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      var lesson = Lesson(
                          id: 0,
                          name: nameController.text,
                          description: descriptionController.text,
                          userId: 0,
                          isPublic: false,
                          status: '',
                          createdAt: '',
                          updatedAt: '');
                      createLesson(lesson, state.lessonDetailList, context);
                    },
                    child: const Icon(Icons.create),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  void createLesson(Lesson lesson, List<LessonDetail> lessonDetailList,
      BuildContext context) {
    context
        .read<LessonBloc>()
        .add(CreateDataLesson(lesson: lesson, lessonDetails: lessonDetailList));
  }

  void _addLessonDetail(BuildContext context) {
    var lessonDetail = LessonDetail(
        term: "",
        definition: "",
        id: detailCount++,
        image: '',
        audio: '',
        video: '',
        status: '',
        createdAt: '',
        updatedAt: '');
    log("_addLessonDetail_addLessonDetail_addLessonDetail ");
    // context.read<LessonBloc>().add(AddLessonDetail(lessonDetail: lessonDetail));
  }
}
