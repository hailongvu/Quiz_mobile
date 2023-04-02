import 'package:flutter/material.dart';

import 'card_preview.dart';

class FlashCard extends StatelessWidget {
  final List<Map<String, String>> flashcards;

  const FlashCard({Key? key, required this.flashcards}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlashCardList(flashcards: flashcards),
    );
  }
}

class FlashCardList extends StatefulWidget {
  final List<Map<String, String>> flashcards;

  const FlashCardList({Key? key, required this.flashcards}) : super(key: key);

  @override
  _FlashCardListState createState() => _FlashCardListState();
}

class _FlashCardListState extends State<FlashCardList> {
  int _currentIndex = 0;
  bool _showAnswer = false;

  void _toggleShowAnswer() {
    setState(() {
      _showAnswer = !_showAnswer;
    });
  }

  void _nextCard() {
    setState(() {
      _currentIndex = (_currentIndex + 1) % widget.flashcards.length;
      _showAnswer = false;
    });
  }

  void _previousCard() {
    setState(() {
      _currentIndex = (_currentIndex - 1 + widget.flashcards.length) %
          widget.flashcards.length;
      _showAnswer = false;
    });
  }

  void _quit() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const FlashCardScreen(
                  setTitle: 'HCM',
                  authorName: 'LongVH',
                  numCards: 10,
                )));
  }

  @override
  Widget build(BuildContext context) {
    final currentFlashcard = widget.flashcards[_currentIndex];
    final cardCount = _currentIndex + 1;
    final totalCards = widget.flashcards.length;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: _toggleShowAnswer,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: 320,
              height: 430,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(16),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Text(
                          _showAnswer
                              ? currentFlashcard['answer']!
                              : currentFlashcard['question']!,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.start,
                          maxLines: 100,
                          overflow: TextOverflow.ellipsis,
                          textScaleFactor:
                              2, // Set textScaleFactor to a large value
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      '$cardCount/$totalCards',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: _previousCard,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  minimumSize: const Size(100, 50),
                ),
                child: const Text('Previous'),
              ),
              ElevatedButton(
                onPressed: _nextCard,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  minimumSize: const Size(100, 50),
                ),
                child: const Text('Next'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  minimumSize: const Size(100, 50),
                ),
                child: const Text('Back'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

final List<Map<String, String>> flashcards = [
  {
    'question':
        'Đâu là nguyên tắc xây dựng đạo đức mới trong tư tưởng Hồ Chí Minh? \na. Nói đi đôi với làm, phải nêu gương về đạo đức \nb. Nói đi đôi với làm, phải nêu gương về lối sống \nc. Nói đi đôi với làm, phải nêu gương về tác phong',
    'answer': 'a. Nói đi đôi với làm, phải nêu gương về đạo đức',
  },
  {
    'question':
        'Trong tư tưởng đạo đức Hồ Chí Minh, đức và tài, hồng và chuyên, phẩm chất và năng lực thống nhất làm một. Đó là đạo đức trong hành động, lấy: a. Số lượng công việc làm thước đo. b. Hiệu quả thực tế làm thước đo. c. Chất lượng công việc làm thước đo. d. Trình độ chuyên môn nghiệp vụ làm thước đo.',
    'answer': 'b. Hiệu quả thực tế làm thước đo.',
  },
  {
    "question":
        "Trong tư tưởng Hồ Chí Minh, bản sắc văn hóa dân tộc ta được hiểu như thế nào?\na. Là nét đặc trưng của văn hóa dân tộc ta.\nb. Là nét đặc trưng của văn hóa dân tộc ta trong thời kỳ đấu tranh giành độc lập dân tộc.\nc. Là sự độc lập, toàn vẹn của văn hóa dân tộc ta.\n",
    "answer": "c"
  },
  {
    "question":
        "Điều gì cần làm để xây dựng và phát triển kinh tế trong tư tưởng Hồ Chí Minh?\na. Đầu tư nhiều tiền vào kinh tế.\nb. Xây dựng nền kinh tế quyết định.\nc. Tập trung vào sản xuất nông nghiệp.\n",
    "answer": "b"
  },
  {
    "question":
        "Trong tư tưởng Hồ Chí Minh, con người có vị trí như thế nào?\na. Là trung tâm của cuộc sống xã hội.\nb. Là cái gì đó không quan trọng.\nc. Là một phần của vật chất.\n",
    "answer": "a"
  },
  {
    'question': 'What is the highest mountain in the world?',
    'answer': 'Mount Everest',
  },
  {
    'question': 'What is the capital of France?',
    'answer': 'Paris',
  },
  {
    'question': 'Who is the person who invented the light bulb?',
    'answer': 'Thomas Edison',
  },
  // add more flashcards as needed
];

// ...

Widget build(BuildContext context) {
  return FlashCard(flashcards: flashcards);
}
