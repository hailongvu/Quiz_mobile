import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../lesson/bloc/event/lesson_event.dart';
import '../lesson/bloc/lesson_bloc.dart';

enum SampleItem { itemOne, itemTwo, itemThree }

class PopupMenu extends StatefulWidget {
  int idLesson;

  PopupMenu({super.key, required this.idLesson});

  @override
  State<PopupMenu> createState() => _PopupMenuState(idLesson);
}

class _PopupMenuState extends State<PopupMenu> {
  final int idLesson;
  SampleItem? selectedMenu;

  _PopupMenuState(this.idLesson);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<SampleItem>(
      initialValue: selectedMenu,
      // Callback that sets the selected popup menu item.
      onSelected: (SampleItem item) {
        setState(() {
          selectedMenu = item;
          if (item == SampleItem.itemOne) {
            context.read<LessonBloc>().add(RemoveLesson(idLessonDetail: idLesson));
          }
        });
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<SampleItem>>[
        const PopupMenuItem<SampleItem>(
          value: SampleItem.itemOne,
          child: Text('Delete'),
        ),
        // const PopupMenuItem<SampleItem>(
        //   value: SampleItem.itemTwo,
        //   child: Text('Item 2'),
        // ),
        // const PopupMenuItem<SampleItem>(
        //   value: SampleItem.itemThree,
        //   child: Text('Item 3'),
        // ),
      ],
    );
  }
}
