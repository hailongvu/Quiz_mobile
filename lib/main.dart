import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:let_learn/course/bloc/course_bloc.dart';
import 'package:let_learn/course/repository/course_repository.dart';
import 'package:let_learn/lesson/bloc/lesson_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:let_learn/home/screen/home.dart';
import 'package:http/http.dart';
import 'package:let_learn/authentication/bloc/authentication_bloc.dart';
import 'package:let_learn/authentication/repository/authentication_repository.dart';

import 'home/screen/screen_home.dart';
import 'lesson/repository/lesson_repository.dart';

void main() {
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<CourseBloc>(
        create: (context) => CourseBloc(courseRepository: CourseRepository()),
      ),
      BlocProvider<LessonBloc>(
        create: (context) => LessonBloc(lessonRepository: LessonRepository()),
      ),
      BlocProvider<AuthenticationBloc>(
        create: (context) => AuthenticationBloc(
            authenticationRepository:
                AuthenticationRepository(httpClient: Client())),
      ),
    ],
    child: const App(),
  ));
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent),
    );

    // check if the user has already seen the onboarding screen
    Future<bool> _hasSeenOnBoarding() async {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getBool('hasSeenOnBoarding') ?? false;
    }

    // set the flag to true so that the onboarding screen is not shown again
    Future<void> _setHasSeenOnBoarding() async {
      final prefs = await SharedPreferences.getInstance();
      prefs.setBool('hasSeenOnBoarding', true);
    }

    return MaterialApp(
      title: 'Let\'s Learn',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // initialRoute: '/',
      // routes: {
      //   '/': (context) => const ScreenHome(),
      //   '/quiz': (context) => QuizScreen(),
      // },
      home: FutureBuilder<bool>(
        future: _hasSeenOnBoarding(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!) {
              return const HomePage();
            } else {
              _setHasSeenOnBoarding();
              return const OnBoardingPage();
            }
          } else {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
        },
      ),
    );
  }
}

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const HomePage()),
    );
  }

  Widget _buildImage(String assetName, [double width = 350]) {
    return Image.asset('assets/images/intro/$assetName', width: width);
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);

    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: Colors.white,
      allowImplicitScrolling: true,
      autoScrollDuration: 3000,
      globalHeader: Align(
        alignment: Alignment.topRight,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 16, right: 16),
            child: _buildImage('logo.png', 100),
          ),
        ),
      ),
      globalFooter: SizedBox(
        width: double.infinity,
        height: 60,
        child: ElevatedButton(
          child: const Text(
            'Get Started',
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
          onPressed: () => _onIntroEnd(context),
        ),
      ),
      pages: [
        PageViewModel(
          title: "Personalized learning experience",
          body:
              "\"Let's Learn\" provides users with a tailored learning experience by offering courses and lessons based on their individual needs and interests.",
          image: _buildImage('intro1.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Wide range of subjects",
          body:
              "The app covers a variety of subjects, ensuring that there is something for everyone. With interactive courses and lessons, users can learn at their own pace and on their own schedule.",
          image: _buildImage('intro2.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Engaging and interactive learning",
          body:
              "\"Let's Learn\" uses a combination of text, videos, quizzes, and other interactive elements to make learning fun and engaging.",
          image: _buildImage('intro3.png'),
          decoration: pageDecoration,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: false,
      skipOrBackFlex: 0,
      nextFlex: 0,
      showBackButton: true,
      //rtl: true, // Display as right-to-left
      back: const Icon(Icons.arrow_back),
      skip: const Text('Skip', style: TextStyle(fontWeight: FontWeight.w600)),
      next: const Icon(Icons.arrow_forward),
      done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      controlsPadding: kIsWeb
          ? const EdgeInsets.all(12.0)
          : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      dotsContainerDecorator: const ShapeDecoration(
        color: Colors.black87,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // check user's login status
  // ignore: no_leading_underscores_for_local_identifiers
  Future<bool> _isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _isLoggedIn(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!) {
            return const Home();
          } else {
            // return Login();
            return const ScreenHome();
          }
        } else {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }
}
