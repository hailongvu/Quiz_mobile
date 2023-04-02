import 'package:flutter/material.dart';
import 'package:let_learn/flash_card/test_screen.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class QuizSave extends ChangeNotifier {
  final List<Map<String, dynamic>> _quizData = quizData[0]["lesson_details"];
  final String _lessonId = 'lesson1';
  final List<int> _userResponses =
      List.generate(quizData.length, (index) => -1);

  // Define getters and setters for _userResponses
  List<int> get userResponses => _userResponses;
  set userResponses(List<int> value) {
    for (int i = 0; i < value.length; i++) {
      _userResponses[i] = value[i];
    }
  }

  Future<void> saveQuizResponse() async {
    Database db =
        await openDatabase(join(await getDatabasesPath(), 'quiz_database.db'));

    // Prepare the quiz_responses row to be inserted or updated
    Map<String, dynamic> quizRow = {
      'lesson_id': _lessonId,
      'question1': _userResponses[0],
      'question2': _userResponses[1],
      'question3': _userResponses[2],
      'question4': _userResponses[3],
      'question5': _userResponses[4],
      'question6': _userResponses[5],
      'question7': _userResponses[6],
      'question8': _userResponses[7],
      'question9': _userResponses[8],
      'question10': _userResponses[9],
      'status': -1, // Set the initial status to -1 (not yet graded)
    };

    // Check if a quiz_responses row already exists for this lesson_id, and update it if it does
    int? count = Sqflite.firstIntValue(await db.rawQuery(
        'SELECT COUNT(*) FROM quiz_responses WHERE lesson_id = ?',
        [_lessonId]));
    if (count == 1) {
      await db.update('quiz_responses', quizRow,
          where: 'lesson_id = ?', whereArgs: [_lessonId]);
    } else {
      // Otherwise, insert a new row
      await db.insert('quiz_responses', quizRow);
    }

    await db.close();
  }

  // Other methods and properties of the QuizSave go here...
}

const List<Map<String, dynamic>> quizData = [
  {
    "lesson_id": "lesson1",
    "lesson_title": "Introduction to Flutter",
    "lesson_details": [
      {
        "id": 1,
        "question":
            "What is Flutter framework used for developing applications?",
        "answers": [
          "Android Development",
          "IOS Development",
          "Web Development",
          "All of the above"
        ],
        "correct_answer_index": 3
      },
      {
        "id": 10,
        "question":
            "Which widget can be used to display progress indicators in Flutter?",
        "answers": [
          "ProgressIndicator",
          "CircularProgressIndicator",
          "LinearProgressIndicator",
          "All of the above"
        ],
        "correct_answer_index": 3
      }
    ]
  }
];
