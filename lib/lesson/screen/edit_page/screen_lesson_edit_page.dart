import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../ui/loading.dart';
import '../../bloc/event/lesson_event.dart';
import '../../bloc/lesson_bloc.dart';
import '../../bloc/states/lesson_state.dart';
import '../../repository/lesson_repository.dart';
import '../../repository/models/model/data_lesson.dart';
import '../edit/screen_edit_lesson.dart';
import '../../../utils/Strings.dart';

class ScreenLessonEditPage extends StatelessWidget {
  final List<DataLesson> items = [];

  ScreenLessonEditPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: const Text(
          headerEditPage,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: BlocProvider(
        create: (context) => LessonBloc(lessonRepository: LessonRepository())
          ..add(const LoadDataLessonDetails(10)),
        child: BlocListener<LessonBloc, LessonState>(
          listener: (context, state) {
            if (state.data is DataLesson) {
              DataLesson dataLesson = state.data as DataLesson;
              items.add(dataLesson);
            }
          },
          child: BlocBuilder<LessonBloc, LessonState>(
            builder: (context, state) {
              return checkStateLesson(state);
            },
          ),
        ),
      ),
    );
  }

  void gotoLessonEditScreen(DataLesson dataLesson, BuildContext context) {
    ScreenEditLesson(dataLesson: dataLesson).launch(context);
  }

  Widget checkStateLesson(LessonState state) {
    if (state.status == LessonStatus.unknown) {
      return const LoadingOverlay();
    }
    if (state.status == LessonStatus.error) {
      toast(state.errorMessage);
      return Stack();
    }
    return showLessonList(state);
  }

  Widget showLessonList(LessonState state) {
    return Column(
      children: [
        Expanded(
          child: ListView.separated(
            //<-- SEE HERE
            itemCount: items.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: CupertinoColors.activeBlue,
                  child: Text(
                    items[index].lesson.id.toString(),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                title: Text(
                  items[index].lesson.name,
                ),
                subtitle: Text(items[index].lesson.description),
                trailing: IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      gotoLessonEditScreen(items[index], context);
                    }),
              );
            },
            separatorBuilder: (context, index) {
              return const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Divider(),
              );
            },
          ),
        ),
      ],
    );
  }
//EasyLoading.dismiss();x
}
