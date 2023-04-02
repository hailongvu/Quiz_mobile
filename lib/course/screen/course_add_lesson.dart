import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:let_learn/course/bloc/course_bloc.dart';
import 'package:let_learn/course/bloc/states/course_state.dart';
import 'package:let_learn/course/repository/course_repository.dart';

class CourseSetScreen extends StatelessWidget {
  const CourseSetScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.add_card),
              )
            ],
            bottom: const TabBar(
              tabs: [
                Tab(
                  text: ('Sets'),
                ),
                Tab(
                  text: ('Studied'),
                ),
                Tab(
                  text: ('Folder'),
                ),
              ],
            )),
        body: BlocProvider(
          create: (context) => CourseBloc(courseRepository: CourseRepository()),
          child: BlocListener<CourseBloc, CourseState>(
            listener: (context, state) {},
            child: BlocBuilder<CourseBloc, CourseState>(
              builder: (context, state) {
                return TabBarView(
                  children: [
                    Container(
                      child: const Text('Entry A'),
                    ),
                    Container(
                      child: const Text('Entry B'),
                    ),
                    Container(
                      child: const Text('Entry C'),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
