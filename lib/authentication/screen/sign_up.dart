import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:let_learn/authentication/bloc/authentication_bloc.dart';
import 'package:let_learn/authentication/repository/authentication_repository.dart';
import 'package:http/http.dart' as http;
import 'package:nb_utils/nb_utils.dart';
import '../bloc/events/authentication_event.dart';
import '../bloc/state/authentication_state.dart';
import '../../utils/Colors.dart';
import '../../utils/Strings.dart';
import '../../utils/Widget.dart';

class SignUpScreen extends StatelessWidget {
  final usernameCon = TextEditingController();
  final passwordCon = TextEditingController();
  final emailCon = TextEditingController();
  final dateOfBirthCon = TextEditingController();


  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: signInBgColor,
      appBar: AppBar(
        backgroundColor: signInBgColor,
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
        create: (context) =>
            AuthenticationBloc(
                authenticationRepository:
                AuthenticationRepository(httpClient: http.Client())),
        child: BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            if (state is AuthenticationStateFailure) {
              toast(state.string);
            }
            if (state is AuthenticationStateAuthenticated) {
              toast('Register Success');
              finish(context);
            }
          },
          child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
              if (state is AuthenticationStateUnauthenticated) {
                return signInForm(context);
              }
              if (state is AuthenticationStateLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              return signInForm(context);
            },
          ),
        ),
      ),
    );
  }

  signInForm(BuildContext context) {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Register", style: boldTextStyle(size: 20)),
            16.height,
          ],
        ).paddingAll(16),
        SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.only(top: 100),
            height: context.height(),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(22)),
                color: colorWhite),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    AppTextField(
                      controller: emailCon,
                      textFieldType: TextFieldType.EMAIL,
                      textStyle: const TextStyle(color: Colors.black54),
                      decoration: const InputDecoration(
                        labelText: email,
                        labelStyle: TextStyle(color: colorBlack),
                        hintStyle: TextStyle(fontSize: 12),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                      ),
                    ),
                    AppTextField(
                      controller: passwordCon,
                      textFieldType: TextFieldType.PASSWORD,
                      decoration: const InputDecoration(
                        labelText: password,
                        labelStyle: TextStyle(color: colorBlack),
                        hintStyle: TextStyle(fontSize: 12),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                      ),
                    ),
                    AppTextField(
                      controller: dateOfBirthCon,
                      textFieldType: TextFieldType.EMAIL,
                      textStyle: const TextStyle(color: Colors.black54),
                      decoration: const InputDecoration(
                        labelText: DOB,
                        labelStyle: TextStyle(color: colorBlack),
                        hintStyle: TextStyle(fontSize: 12),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                      ),
                      onTap: () async {
                        DateTime? date = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime(2100));
                        dateOfBirthCon.text = date.toString();
                      },
                    ),
                    16.height,
                  ],
                ),
                24.height,
                Column(
                  children: [
                    appButton(
                      context,
                      btnText: signUp,
                      bgColor: signInBgColor,
                      width: context.width(),
                      shape: 10.0,
                      txtColor: colorSkyBlue,
                      onPress: () {
                        BlocProvider.of<AuthenticationBloc>(context).add(
                          AuthenticationEventRegister(
                              usernameCon.text, emailCon.text, passwordCon.text,  dateOfBirthCon.text)
                        );
                      },

                    ).paddingSymmetric(horizontal: 16),
                    16.height,

                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

}
