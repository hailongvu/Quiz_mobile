import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nb_utils/nb_utils.dart';

import 'ClassDetail.dart';

class CreateClass extends StatelessWidget {
  final ButtonStyle style =
      ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));
  final classNameController = TextEditingController();
  final classDescriptionController = TextEditingController();

  CreateClass({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Class'),
      ),
      body:
          // BlocProvider(create: create, child: BlocListener<SetBloc, SetState>(
          //   listener: (context, state) {},
          //   child: BlocBuilder<SetBloc, SetState>(
          //     builder: (context, state) {
          // return Column(
          Column(
        children: [
          Container(
            margin: const EdgeInsets.all(10),
            child: TextField(
              controller: classNameController,
              decoration: const InputDecoration(
                hintText: 'Name',
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(10),
            child: TextField(
              controller: classDescriptionController,
              decoration: const InputDecoration(
                hintText: 'Description',
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(10),
            child: ElevatedButton(
              style: style,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ClassDetail()),
                );
              },
              child: const Text('Create'),
            ),
          ),
        ],
        // );

        // ),
        //     ),
        //   );
        // }
      ),
    );
  }
}
