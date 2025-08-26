import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:language_learning_app/Screens/GrammerLearning/grammer_lesson_page.dart';
import 'package:language_learning_app/Screens/GrammerLearning/grammer_quiz.dart';
import 'package:language_learning_app/Screens/quizpage.dart'; // import QuizPage

class SubLessonPage extends StatelessWidget {
  final String title;
  final Map<String, dynamic> types;
  final quizCategory;

  const SubLessonPage({
    required this.title,
    required this.types,
    required this.quizCategory,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title), centerTitle: true),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children:
                  types.keys.map((subTitle) {
                    final details = types[subTitle]!;

                    return Card(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: ListTile(
                        title: Text(
                          subTitle,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (_) => GrammerLessonPage(
                                    title: subTitle,
                                    explanation: details["explanation"],
                                    examples: List<String>.from(
                                      details["examples"],
                                    ),
                                  ),
                            ),
                          );
                        },
                      ),
                    );
                  }).toList(),
            ),
          ),

          // Take Quiz button at bottom
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => TakeQuizPage(quizType: quizCategory),
                  ),
                );
              },
              icon: const Icon(Icons.quiz),
              label: const Text("Take Quiz"),
            ),
          ),
        ],
      ),
    );
  }
}
