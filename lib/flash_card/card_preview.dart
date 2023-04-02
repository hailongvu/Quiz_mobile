import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:let_learn/flash_card/test_screen.dart';
import 'flash_card.dart';

class FlashCardScreen extends StatelessWidget {
  final String setTitle;
  final String authorName;
  final int numCards;

  const FlashCardScreen({
    Key? key,
    required this.setTitle,
    required this.authorName,
    required this.numCards,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flash Cards preview'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (result) {
              // Add your code here to handle the selected menu item
            },
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem(
                value: 'addFolder',
                child: Text('Add to folder'),
              ),
              const PopupMenuItem(
                value: 'share',
                child: Text('Share'),
              ),
              const PopupMenuItem(
                value: 'setInfo',
                child: Text('Set info'),
              ),
              const PopupMenuItem(
                value: 'delete',
                child: Text('Delete set'),
              ),
              const PopupMenuItem(
                value: 'cancel',
                child: Text('Cancel'),
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: 16.0,
            ),
            CarouselSlider.builder(
              itemCount: questionsAndAnswers.length
                  .clamp(0, 15), // limit to a maximum of 15 sliders
              itemBuilder: (BuildContext context, int index, int realIndex) {
                return Container(
                  width: MediaQuery.of(context).size.width - 32,
                  margin: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            questionsAndAnswers[index]['question']!,
                            style: const TextStyle(
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            questionsAndAnswers[index]['answer']!,
                            style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              options: CarouselOptions(
                height: 250,
                viewportFraction: 0.85,
                enlargeCenterPage: true,
                enableInfiniteScroll: false,
                initialPage: 0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                setTitle,
                style: const TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              leading: CircleAvatar(
                child: Text(authorName[0]),
              ),
              title: Text(authorName),
              subtitle: Text('$numCards cards'),
            ),
            const Divider(),
            Column(
              children: [
                const SizedBox(
                  height: 30.0,
                ),
                ListTile(
                  title: const Text('Flash Cards'),
                  leading: const Icon(Icons.flash_on),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              FlashCard(flashcards: flashcards)),
                    );
                  },
                ),
                const SizedBox(
                  height: 16.0,
                ),
                ListTile(
                  title: const Text('Learn'),
                  leading: const Icon(Icons.book),
                  onTap: () {
                    print('Navigating to quiz page...');
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => QuizScreen()),
                    );
                  },
                ),
                const Divider(),
                SingleChildScrollView(
                  child: Column(
                    children: questionsAndAnswers.map((qa) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  qa['question']!,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const Divider(),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  qa['answer']!,
                                  style: const TextStyle(fontSize: 18),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

final List<Map<String, String>> questionsAndAnswers = [
  {'question': 'What is the capital of France?', 'answer': 'Paris'},
  {
    'question': 'What is the tallest mountain in the world?',
    'answer': 'Mount Everest'
  },
  {
    'question': 'Who is the author of "To Kill a Mockingbird"?',
    'answer': 'Harper Lee'
  },
  {
    'question':
        'Đâu là nguyên tắc xây dựng đạo đức mới trong tư tưởng Hồ Chí Minh? \na. Nói đi đôi với làm, phải nêu gương về đạo đức \nb. Nói đi đôi với làm, phải nêu gương về lối sống \nc. Nói đi đôi với làm, phải nêu gương về tác phong',
    'answer': 'a. Nói đi đôi với làm, phải nêu gương về đạo đức',
  },
  {
    'question':
        'Trong di chúc Hồ Chí Minh viết rằng\na. Đảng phải có kế hoạch tốt để phát triển kinh tế, văn hóa\nb. Đảng phải có kế hoạch tốt để phát triển kinh tế, chính trị\nc. Đảng phải có kế hoạch tốt để phát triển kinh tế, xã hội',
    'answer': 'a. Đảng phải có kế hoạch tốt để phát triển kinh tế, văn hóa',
  },
  {
    "question":
        "Theo Hồ Chí Minh phải chú trọng 'đạo làm gương'. Đối với Người 'một tấm gương sống còn có giá trị hơn:\na. một trăm bài diễn văn tuyên truyền',\nb. một trăm hòm vàng',\nc. một trăm tủ sách'\n",
    "answer": "a"
  },
  {
    "question":
        "Đâu là chuẩn mực đạo đức cách mạng trong tư tưởng Hồ Chí Minh?\na. Cần, kiệm, liêm, chính, chí công vô tư.\nb. Cần, kiệm, liêm, chính, sáng suốt.\nc. Cần, kiệm, liêm, chính, tự do.\n",
    "answer": "a"
  },
  {
    "question":
        "Theo Hồ Chí Minh, đạo đức là nhân tố tạo nên:\na. sức mạnh, sức hấp dẫn của chủ nghĩa xã hội.\nb. sức mạnh, sức hấp dẫn của chủ nghĩa Mác-Lênin.\nc. sức mạnh, sức hấp dẫn của tư tưởng Hồ Chí Minh.\n",
    "answer": "c"
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
    'question': 'What is the smallest country in the world by land area?',
    'answer': 'Vatican City',
  },
  {
    'question': 'What is the largest country in the world by land area?',
    'answer': 'Russia',
  },
  {
    'question': 'Who is the first person to walk on the moon?',
    'answer': 'Neil Armstrong',
  },
  {
    'question': 'What is the capital of Japan?',
    'answer': 'Tokyo',
  },
  {
    'question': 'Who wrote "Pride and Prejudice"?',
    'answer': 'Jane Austen',
  },
  {
    'question': 'What is the largest ocean in the world?',
    'answer': 'Pacific Ocean',
  },
];
