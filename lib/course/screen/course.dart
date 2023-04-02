import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:let_learn/course/bloc/course_bloc.dart';
import 'package:let_learn/course/bloc/event/course_event.dart';
import 'package:let_learn/course/bloc/states/course_state.dart';
import 'package:let_learn/course/repository/course_repository.dart';
import 'package:let_learn/course/repository/models/model/data_course.dart';
import 'package:let_learn/course/screen/course_add_lesson.dart';
import 'package:let_learn/lesson/repository/models/model/data_lesson.dart';
import 'package:let_learn/ui/loading.dart';

import 'package:nb_utils/nb_utils.dart';

class CourseScreen extends StatelessWidget {
  final List<DataCourse> items = [];
  CourseScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.add_card),
            )
          ],
        ),
        body: BlocProvider(
            create: (context) =>
                CourseBloc(courseRepository: CourseRepository())
                  ..add(const LoadDataCourseDetails(2)),
            child: BlocListener<CourseBloc, CourseState>(
              listener: (context, state) {
                if (state.data is DataCourse) {
                  DataCourse dataCourse = state.data as DataCourse;
                  items.add(dataCourse);
                }
              },
              child: BlocBuilder<CourseBloc, CourseState>(
                builder: (context, state) {
                  return checkStateCourse(state);
                },
              ),
            )));
  }

  Widget checkStateCourse(CourseState state) {
    if (state.status == CourseStatus.unknown) {
      return const LoadingOverlay();
    }
    if (state.status == CourseStatus.error) {
      toast(state.errorMessage);
      return Stack();
    }
    return showCourse(state);
  }

  Widget showCourse(CourseState state) {
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
                    items[index].course.id.toString(),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                title: Text(
                  items[index].course.name,
                ),
                subtitle: Text(items[index].course.userId.toString()),
              );
            },
            separatorBuilder: (context, index) {
              //<-- SEE HERE
              return const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Divider(),
              );
            },
          ),
        ),
        SizedBox(
          height: 550,
          child: Center(
            child: Column(
              // add Column
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text('Welcome',
                    style: TextStyle(
                        // your text
                        fontSize: 50.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Add sets'),
                ), // your button beneath text
              ],
            ),
          ),
        ),
      ],
    );
  }
}
