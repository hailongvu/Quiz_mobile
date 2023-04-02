import 'package:flutter/material.dart';
import 'package:let_learn/flash_card/quiz_save.dart';
import 'package:let_learn/flash_card/quiz_page.dart';

class QuizScreen extends StatelessWidget {
  final List<Map<String, dynamic>> _quizData = quizData[0]["lesson_details"];

  QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome to the Quiz!',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Scaffold(body: QuizPage())),
                );
              },
              child: const Text('Start Quiz'),
            )
          ],
        ),
      ),
    );
  }
}
