import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../lesson/bloc/event/lesson_event.dart';
import '../../../lesson/bloc/lesson_bloc.dart';
import '../../../lesson/bloc/states/lesson_state.dart';
import '../../../lesson/repository/lesson_repository.dart';
import '../../../lesson/screen/edit/screen_edit_lesson.dart';

class ScreenProfile extends StatelessWidget {
  const ScreenProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text(
          "Screen 2",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: BlocProvider(
        create: (context) =>
            LessonBloc(lessonRepository: LessonRepository())
              ..add(LoadDataLessonDetails(23)),
        child: BlocListener<LessonBloc, LessonState>(
          listener: (context, state) {},
          child: BlocBuilder<LessonBloc, LessonState>(
            builder: (context, state) {
              return Column(
                children: [
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    elevation: 5,
                    color: Color(0xFF90CAF9),
                    child: ListTile(
                        title: TextField(
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            labelText: state.dataLesson.lesson.name,
                            contentPadding: EdgeInsets.all(10),
                          ),
                          onChanged: (text) {},
                        ),
                        subtitle: TextField(
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            labelText: state.dataLesson.lesson.description,
                            contentPadding: EdgeInsets.all(10),
                          ),
                          onChanged: (text) {},
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.edit),
                          color: Colors.white,
                          tooltip: 'Increase volume by 10',
                          onPressed: () {
                            ScreenEditLesson(dataLesson: state.dataLesson).launch(context);
                          },
                        ),
                        onLongPress: () {}),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
