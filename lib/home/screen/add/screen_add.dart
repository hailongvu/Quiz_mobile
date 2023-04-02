import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:let_learn/course/bloc/event/course_event.dart';
import 'package:let_learn/course/bloc/states/course_state.dart';
import 'package:let_learn/course/repository/course_repository.dart';
import 'package:let_learn/course/screen/course.dart';
import 'package:let_learn/lesson/screen/create/screen_create_new_lesson.dart';
import 'package:let_learn/utils/Colors.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:open_file/open_file.dart';
import '../../../class_/CreateClass.dart';
import '../../../course/bloc/course_bloc.dart';
import '../../../course/repository/models/model/course.dart';
import '../../../lesson/screen/edit_page/screen_lesson_edit_page.dart';

class ScreenAdd extends StatelessWidget {
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();

  ScreenAdd({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: signInBgColor,
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.person),
          )
        ],
      ),
      body: BlocProvider(
        create: (context) => CourseBloc(courseRepository: CourseRepository()),
        child: BlocListener<CourseBloc, CourseState>(
          listener: (context, state) {
            log('12312${state.status}');
            handleStateResponse(state, context);
          },
          child: BlocBuilder<CourseBloc, CourseState>(
            builder: (context, state) {
              return SafeArea(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      16.height,
                      SizedBox(
                        height: 70,
                        width: 170,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 15,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32.0),
                            ),
                          ),
                          onPressed: () {
                            ScreenLessonEditPage().launch(context);
                          },
                          child: const Text(" Edit Lesson ",
                              style: TextStyle(fontSize: 20)),
                        ),
                      ),
                      30.height,
                      SizedBox(
                        height: 70,
                        width: 170,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 15,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32.0),
                            ),
                          ),
                          onPressed: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (BuildContext context) {
                                  return Container(
                                    height: 160,
                                    color: Colors.white,
                                    child: Center(
                                      child: Column(
                                        children: [
                                          ListTile(
                                            title:
                                                const Text("Create new lesson"),
                                            trailing: const Icon(
                                                Icons.arrow_forward_ios),
                                            onTap: () {
                                              CreateLessonNew().launch(context);
                                            },
                                          ),
                                          ListTile(
                                              trailing: const Icon(
                                                  Icons.arrow_forward_ios),
                                              title: const Text(
                                                  "Import new lesson"),
                                              onTap: () {
                                                showModalBottomSheet(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return Container(
                                                        height: 160,
                                                        color: Colors.white,
                                                        child: Center(
                                                          child: Column(
                                                            children: [
                                                              ListTile(
                                                                title: const Text(
                                                                    "Import Text File"),
                                                                trailing:
                                                                    const Icon(Icons
                                                                        .arrow_forward_ios),
                                                                onTap:
                                                                    () async {
                                                                  FilePickerResult?
                                                                      result =
                                                                      await FilePicker
                                                                          .platform
                                                                          .pickFiles(
                                                                    type: FileType
                                                                        .custom,
                                                                    allowedExtensions: [
                                                                      'txt'
                                                                    ],
                                                                  );
                                                                  if (result ==
                                                                      null) {
                                                                    return;
                                                                  }
                                                                  final file =
                                                                      result
                                                                          .files
                                                                          .first;
                                                                  openFile(
                                                                      file);
                                                                },
                                                              ),
                                                              ListTile(
                                                                trailing:
                                                                    const Icon(Icons
                                                                        .arrow_forward_ios),
                                                                title: const Text(
                                                                    "Import CSV File"),
                                                                onTap:
                                                                    () async {
                                                                  FilePickerResult?
                                                                      result =
                                                                      await FilePicker
                                                                          .platform
                                                                          .pickFiles(
                                                                    type: FileType
                                                                        .custom,
                                                                    allowedExtensions: [
                                                                      'csv'
                                                                    ],
                                                                  );
                                                                  if (result ==
                                                                      null) {
                                                                    return;
                                                                  }
                                                                  final file =
                                                                      result
                                                                          .files
                                                                          .first;
                                                                  openFile(
                                                                      file);
                                                                },
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      );
                                                    });
                                              }),
                                        ],
                                      ),
                                    ),
                                  );
                                });
                          },
                          child: const Text("   Add Lesson   ",
                              style: TextStyle(fontSize: 20)),
                        ),
                      ),
                      30.height,
                      SizedBox(
                        height: 70,
                        width: 170,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 15,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32.0),
                            ),
                          ),
                          onPressed: () {
                            courseDialog(context);
                          },
                          child: const Text("   Add Course   ",
                              style: TextStyle(fontSize: 20)),
                        ),
                      ),
                      30.height,
                      SizedBox(
                        height: 70,
                        width: 170,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 15,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32.0),
                            ),
                          ),
                          onPressed: () {
                            CourseScreen().launch(context);
                          },
                          child: const Text("   Course   ",
                              style: TextStyle(fontSize: 20)),
                        ),
                      ),
                      30.height,
                      SizedBox(
                        height: 70,
                        width: 170,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 15,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32.0),
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CreateClass()),
                            );
                          },
                          child: const Text(" Add Class ",
                              style: TextStyle(fontSize: 20)),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void openFile(PlatformFile file) {
    OpenFile.open(file.path!);
  }

  void courseDialog(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Create folder', style: boldTextStyle(size: 20)),
            content: SizedBox(
              height: 100,
              child: Column(
                children: [
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      hintText: "",
                    ),
                  ),
                  TextField(
                    controller: descriptionController,
                    decoration: const InputDecoration(
                      hintText: "",
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("CANCEL",
                    style: boldTextStyle(size: 16, color: colorSkyBlue)),
              ),
              TextButton(
                onPressed: () {
                  var course = Course(
                    id: 0,
                    name: nameController.text,
                    description: descriptionController.text,
                    userId: 0,
                    status: '',
                    isPublic: false,
                    createdAt: '',
                    updatedAt: '',
                  );
                  createCourse(course, context);
                },
                child: Text("OK",
                    style: boldTextStyle(size: 16, color: colorSkyBlue)),
              ),
            ],
          );
        });
  }

  void createCourse(Course course, BuildContext context) {
    context.read<CourseBloc>().add(CreateCourse(course: course));
  }

  void handleStateResponse(CourseState state, BuildContext context) {
    if (state.status == CourseStatus.error) {
      toast(state.errorMessage);
    }
    if (state.status == CourseStatus.created ||
        state.status == CourseStatus.success) {
      toast('Success');
      CourseScreen().launch(isNewTask: true, context);
    }
    log(' Course Screen ${state.status}');
  }
}
