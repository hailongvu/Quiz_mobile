import 'package:flutter/material.dart';
import 'package:let_learn/authentication/screen/sign_up.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:let_learn/utils/Colors.dart';
import 'package:let_learn/utils/Images.dart';
import 'package:let_learn/utils/Strings.dart';
import 'package:let_learn/utils/Widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:let_learn/authentication/bloc/authentication_bloc.dart';
import 'package:let_learn/authentication/repository/authentication_repository.dart';
import 'package:http/http.dart' as http;

import '../bloc/events/authentication_event.dart';
import '../bloc/state/authentication_state.dart';
import '../../home/navigationbar/navigation_bar.dart';


class Login extends StatelessWidget {
  var emailCon = TextEditingController();
  var passwordCon = TextEditingController();

  Login({super.key});

  @override
  Widget build(BuildContext context) {
    emailCon.text = "admin@pontas.dev";
    passwordCon.text = "1234567890";
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
        create: (context) => AuthenticationBloc(
            authenticationRepository:
                AuthenticationRepository(httpClient: http.Client())),
        child: BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            print(state);
            if (state is AuthenticationStateFailure) {
              toast(state.string);
            }
            if (state is AuthenticationStateAuthenticated) {
              toast('Login Success');
              finish(context);
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => BottomNavbar()));
            }
          },
          child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
              if (state is AuthenticationStateUnauthenticated) {
                return loginForm(context);
              }
              if (state is AuthenticationStateLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              return loginForm(context);
            },
          ),
        ),
      ),
    );
  }

  loginForm(BuildContext context) {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(welcomeBack, style: boldTextStyle(size: 20)),
            16.height,
            Text(signInSubTitle, style: primaryTextStyle(size: 16)),
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
                    16.height,
                    Text(forgot, style: primaryTextStyle()),
                    Text(forgotPass, style: boldTextStyle(size: 16, color: colorSkyBlue))
                        .onTap(() {
                      forgotDialog(context);
                    }),
                    16.height,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            width: 80,
                            height: 1,
                            color: appDividerColor,
                            margin: const EdgeInsets.only(right: 10)),
                        const Text('or',
                            style: TextStyle(color: appDividerColor)),
                        Container(
                            width: 80,
                            height: 1,
                            color: appDividerColor,
                            margin: const EdgeInsets.only(left: 10)),
                      ],
                    ),
                    16.height,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: 130,
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                              border: Border.all(color: appDividerColor)),
                          child: Image.asset(googleLogo,
                              height: 20, width: 20),
                        ),
                        Container(
                          width: 130,
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                              border: Border.all(color: appDividerColor)),
                          child:
                          Image.asset(appleLogo, height: 20, width: 20),
                        ),
                      ],
                    ),
                  ],
                ),
                24.height,
                Column(
                  children: [
                    appButton(
                      context,
                      btnText: signIn,
                      bgColor: signInBgColor,
                      width: context.width(),
                      shape: 10.0,
                      txtColor: colorSkyBlue,
                      onPress: () {
                        BlocProvider.of<AuthenticationBloc>(context).add(
                          AuthenticationEventLogin(
                              emailCon.text, passwordCon.text),
                        );
                      },

                    ).paddingSymmetric(horizontal: 16),
                    16.height,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(dontHaveAccount, style: primaryTextStyle()),
                        Text(signUp, style: boldTextStyle(size: 16, color: colorSkyBlue))
                            .onTap(() {
                          SignUpScreen().launch(context);
                        }),
                      ],
                    ).center(),
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
  void forgotDialog(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(inputEmail, style: boldTextStyle(size: 20)),
            content: TextField(
              controller: emailCon,
              decoration: InputDecoration(
                hintText: email,
                hintStyle: secondaryTextStyle(),
                border: OutlineInputBorder(),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("cancel", style: boldTextStyle(size: 16, color: colorSkyBlue)),
              ),
              TextButton(
                onPressed: () {
                  BlocProvider.of<AuthenticationBloc>(context).add(
                    AuthenticationEventForgotPassword(
                        emailCon.text),
                  );
                },
                child: Text("submit", style: boldTextStyle(size: 16, color: colorSkyBlue)),
              ),
            ],
          );
        });
  }
}