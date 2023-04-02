import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class QuizQuestion {
  String question;
  List<String> answerOptions;
  String correctAnswer;

  QuizQuestion(
      {required this.question,
      required this.answerOptions,
      required this.correctAnswer});
}

class QuizPage extends StatelessWidget {
  final PageController _pageController = PageController(initialPage: 0);
  late final List<QuizQuestion> _questions = [];
  late final List<int?> _selectedAnswers =
      List<int?>.filled(_quizData.length, null);

  QuizPage({super.key});

  @override
  Widget build(BuildContext context) {
    for (var i = 0; i < _quizData.length; i++) {
      var lessonDetails = _quizData[i]['lesson_details'];
      for (var j = 0; j < lessonDetails.length; j++) {
        var questionData = lessonDetails[j];
        var question = QuizQuestion(
          questionText: questionData['question'],
          answers: List<String>.from(questionData['answers']),
          correctAnswerIndex: questionData['correct_answer'],
        );
        _questions.add(question);
      }
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Quiz')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: _questions.length,
              itemBuilder: (context, index) {
                return QuizQuestionWidget(
                  question: _questions[index],
                  selectedAnswer: _selectedAnswers[index],
                  onAnswerSelected: (answerIndex) {
                    if (index < _questions.length - 1) {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                );
              },
            ),
          ),
          ElevatedButton(
            child: const Text('Submit'),
            onPressed: () async {
              // Calculate score based on selected answers
              var numCorrect = 0;
              for (var i = 0; i < _questions.length; i++) {
                if (_selectedAnswers[i] == _questions[i].correctAnswerIndex) {
                  numCorrect++;
                }
              }
              var score = numCorrect / _questions.length * 100;

              // Save results to SQLite database
              var db = await openDatabase(
                join(await getDatabasesPath(), 'quiz_results.db'),
                onCreate: (db, version) {
                  return db.execute(
                    'CREATE TABLE quiz_results(id INTEGER PRIMARY KEY, score REAL)',
                  );
                },
                version: 1,
              );
              await db.insert('quiz_results', {'score': score});

              // Show results dialog and reset quiz
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Quiz results'),
                    content: Text('You scored $score%'),
                    actions: [
                      TextButton(
                        child: const Text('OK'),
                        onPressed: () {
                          Navigator.pop(context);
                          _selectedAnswers.fillRange(
                              0, _questions.length, null);
                          _pageController.jumpToPage(0);
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

class QuizQuestionWidget extends StatelessWidget {
  final QuizQuestion question;
  final int? selectedAnswer;
  final ValueChanged<String>? onAnswerSelected;

  const QuizQuestionWidget({
    Key? key,
    required this.question,
    required this.selectedAnswer,
    required this.onAnswerSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question.questionText,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          ...List.generate(
            question.answers.length,
            (index) {
              return RadioListTile(
                title: Text(question.answers[index]),
                value: index,
                groupValue: selectedAnswer,
                onChanged: (value) =>
                    onAnswerSelected!(question.answers[value as int]),
              );
            },
          ),
          const SizedBox(height: 16),
          // print('Correct answer index: ${question.correctAnswerIndex}'),
          Text(
            'Correct answer: ${question.answers[int.parse(question.correctAnswerIndex)]}',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

// The quiz data
final List<Map<String, dynamic>> _quizData = [
  {
    "lesson_id": "15",
    "lesson_details": [
      {
        'id': 1,
        'question': 'What is the capital of France?',
        'answers': ['Paris', 'Berlin', 'London', 'Madrid'],
        'correct_answer': 'Paris',
      },
      {
        'id': 2,
        'question': 'What is the currency of Japan?',
        'answers': ['Dollar', 'Euro', 'Yen', 'Pound'],
        'correct_answer': 'Yen',
      },
      {
        'id': 3,
        'question': 'What is the highest mountain in the world?',
        'answers': [
          'Mount Kilimanjaro',
          'Mount Everest',
          'Mount Fuji',
          'Mount Rushmore'
        ],
        'correct_answer': 'Mount Everest',
      },
      {
        "id": 672,
        "question": "QN=5 Đối với các dân tộc thuộc địa, cách mạng tháng Mười:",
        "answers": [
          "Đã nêu tấm gương sáng trong việc giải phóng các dân tộc bị áp bức",
          "Đã mở đầu cho phong trào đấu tranh giải phóng dân tộc",
          "Đã là trụ cột của phong trào giải phóng dân tộc",
          "Đã thức tỉnh phong trào thi đua yêu nước"
        ],
        "correct_answer": "A"
      },
      {
        "id": 673,
        "question": "QN=6 Tổ chức cộng sản nào ra đời đầu tiên ở Việt Nam?",
        "answers": [
          "Hội Việt Nam cách mạng thanh niên",
          "Đông Dương cộng sản Đảng",
          "An Nam cộng sản đảng",
          "Đông Dương cộng sản liên đoàn"
        ],
        "correct_answer": "B"
      },
      {
        "id": 674,
        "question":
            "QN=7 Các phong trào yêu nước trước khi Đảng Cộng sản Việt Nam ra đời đều thất bại nhưng đã có tác dụng to lớn đó là:",
        "answers": [
          "Tạo cơ sở xã hội cho sự tiếp nhận chủ nghĩa Mác-Lênin",
          "Tạo cơ sở cho nhân dân tập dượt làm cách mạng",
          "Tạo cơ sở thành lập Đảng Cộng sản Việt Nam",
          "Tăng cường sức mạnh cho giai cấp công nhân"
        ],
        "correct_answer": "A"
      },
      {
        "id": 675,
        "question":
            "QN=8 Trước sự xâm lược của thực dân Pháp, phong trào yêu nước của nhân dân ta đã diễn ra theo nhiều khuynh hướng khác nhau. Phong trào yêu nước do Việt Nam quốc dân Đảng khởi xướng theo khuynh hướng nào sau đây:",
        "answers": [
          "Khuynh hướng phong kiến",
          "Khuynh hướng vô sản",
          "Khuynh hướng dân chủ tư sản",
          "Khuynh hướng tiểu tư sản"
        ],
        "correct_answer": "C"
      },
      {
        "id": 9998,
        "question":
            "QN=2 Chính sách thống trị của thực dân Pháp ở Việt Nam và Đông Dương có nội dung cơ bản là:",
        "answers": [
          "Tự do nhân quyền",
          "Đã là trụ cột của phong trào giải phóng dân tộc",
          "Thực hiện chính sách ngu dân, duy trì các hủ tục lạc hậu trong nhân dân t",
          "Tự do nhân quyền"
        ],
        "correct_answer": "Tự do nhân quyền"
      },
      {
        "id": 9999,
        "question":
            "QN=2 Chính sách thống trị của thực dân Pháp ở Việt Nam và Đông Dương có nội dung cơ bản là:",
        "answers": ["True", "False"],
        "correct_answer": "A"
      },
      {
        "id": 10000,
        "question":
            "QN=429 Năm 1976 tại Đại hội lần thứ IV, Đảng ta lấy tên là « Đảng Cộng sản Việt Nam ». Đây là lần đổi tên chính thức thứ mấy của Đảng?",
        "answers": ["False", "True"],
        "correct_answer": "B"
      },
      {
        "id": 10001,
        "question":
            "QN=429 Năm 1976 tại Đại hội lần thứ IV, Đảng ta lấy tên là « Đảng Cộng sản Việt Nam ». Đây là lần đổi tên chính thức thứ mấy của Đảng?",
        "answers": ["False", "True"],
        "correct_answer": "B"
      },
      {
        "id": 10002,
        "question":
            "QN=2 Chính sách thống trị của thực dân Pháp ở Việt Nam và Đông Dương có nội dung cơ bản là:",
        "answers": [
          "Đã nêu tấm gương sáng trong việc giải phóng các dân tộc bị áp bức",
          "Tự do",
          "Đông Dương cộng sản liên đoàn",
          "Tự do nhân quyền"
        ],
        "correct_answer": "Tự do"
      },
      {
        "id": 10003,
        "question":
            "QN=2 Chính sách thống trị của thực dân Pháp ở Việt Nam và Đông Dương có nội dung cơ bản là:",
        "answers": [
          "Tự do nhân quyền",
          "Tăng cường sức mạnh cho giai cấp công nhân",
          "Nhân Quyền",
          "Tự do nhân quyền"
        ],
        "correct_answer": "Nhân Quyền"
      },
      {
        "id": 10004,
        "question":
            "QN=2 Chính sách thống trị của thực dân Pháp ở Việt Nam và Đông Dương có nội dung cơ bản là:",
        "answers": [
          "Tự do nhân quyền",
          "Đạo đức",
          "Tạo cơ sở thành lập Đảng Cộng sản Việt Nam",
          "Tự do nhân quyền"
        ],
        "correct_answer": "Đạo đức"
      }
    ],
  }
];
