import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:let_learn/utils/Colors.dart';
import 'package:http/http.dart' as http;
import 'package:let_learn/utils/Strings.dart';
import '../../../authentication/bloc/authentication_bloc.dart';
import 'package:open_file/open_file.dart';

import '../../../authentication/bloc/state/authentication_state.dart';
import '../../../authentication/repository/authentication_repository.dart';

class CreateSet extends StatelessWidget {
  const CreateSet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: signInBgColor,
      appBar: AppBar(
        backgroundColor: colorSkyBlue,
        leading: const Icon(Icons.arrow_back_ios_outlined, size: 20).onTap(() {
          finish(context);
        }),
        elevation: 0.0,
        actions: [
          IconButton(
              icon: const Icon(Icons.more_horiz, size: 20), onPressed: () {})
        ],
      ),
      body: BlocProvider(
        create: (context) => AuthenticationBloc(
            authenticationRepository:
                AuthenticationRepository(httpClient: http.Client())),
        child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            if (state is AuthenticationStateUnauthenticated) {
              return createStudySetForm(context);
            }
            if (state is AuthenticationStateLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            return createStudySetForm(context);
          },
        ),
      ),
    );
  }

  createStudySetForm(BuildContext context) {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("create_studySet", style: boldTextStyle(size: 20)),
            16.height,
            Text("create_studySetOpion", style: primaryTextStyle(size: 16)),
          ],
        ).paddingAll(16),
        Container(
          margin: const EdgeInsets.only(top: 100, left: 100),
          height: context.height(),
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(22)),
              color: signInBgColor),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FloatingActionButton.extended(
                        label: Text(
                          "Create new set",
                          style: primaryTextStyle(color: appDividerColor),
                        ),
                        backgroundColor: green,
                        icon: const Icon(
                          Icons.add,
                          color: appDividerColor,
                        ),
                        onPressed: () {
                          // CreateNew().launch(context);
                        }),
                    30.height,
                    FloatingActionButton.extended(
                        label: Text(
                          "Import new set",
                          style: primaryTextStyle(color: appDividerColor),
                        ),
                        backgroundColor: green,
                        icon: const Icon(
                          Icons.add,
                          color: appDividerColor,
                        ),
                        onPressed: () async {
                          FilePickerResult? result =
                              await FilePicker.platform.pickFiles();
                          if (result == null) return;
                          final file = result.files.first;
                          openFile(file);
                        }),
                    16.height,
                  ]),
            ],
          ),
        ),
      ],
    );
  }

  void openFile(PlatformFile file) {
    OpenFile.open(file.path!);
  }
}
