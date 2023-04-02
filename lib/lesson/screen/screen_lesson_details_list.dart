import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/event/lesson_event.dart';
import '../bloc/lesson_bloc.dart';
import '../repository/models/details/lesson_details.dart';

class ScreenLessonDetailList extends StatelessWidget {
  List<LessonDetail> lessonDetailsList = [];

  ScreenLessonDetailList({Key? key, required this.lessonDetailsList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return lessonDetailsList.isEmpty
        ? const Text('Lesson detail is empty')
        : Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              itemCount: lessonDetailsList.length,
              separatorBuilder: (context, index) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                var termController = TextEditingController();
                var definitionController = TextEditingController();
                termController.text = lessonDetailsList[index].term;
                definitionController.text = lessonDetailsList[index].definition;
                return SizedBox(
                  height: 140,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    elevation: 5,
                    color: Colors.white,
                    child: ListTile(
                      title: TextField(
                        controller: termController,
                        decoration: const InputDecoration(
                          labelText: 'Term',
                          contentPadding: EdgeInsets.all(10),
                        ),
                        onChanged: (text) {
                          lessonDetailsList[index].term = text;
                        },
                      ),
                      subtitle: TextField(
                        controller: definitionController,
                        decoration: const InputDecoration(
                          labelText: 'Definition',
                          contentPadding: EdgeInsets.all(10),
                        ),
                        onChanged: (text) {
                          lessonDetailsList[index].definition = text;
                        },
                      ),
                      trailing: IconButton(
                          onPressed: () {
                            removeLessonDetails(context, index);
                          },
                          icon: const Icon(Icons.delete)),
                    ),
                  ),
                );
              },
            ),
          );
  }

  void removeLessonDetails(BuildContext context, int index) {
    int idLessonDetail = -1;
    if (lessonDetailsList.length > 1) {
      idLessonDetail = lessonDetailsList[index].id;
    }
    context.read<LessonBloc>().add(RemoveLessonDetail(
        idLessonDetail: idLessonDetail, lessonDetailsList: lessonDetailsList));
  }
}
