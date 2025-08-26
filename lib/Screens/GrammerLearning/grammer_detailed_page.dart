import 'package:flutter/material.dart';
import 'package:language_learning_app/DataLayer/grammer_lesson_data.dart';
import 'package:language_learning_app/Screens/GrammerLearning/grammer_lesson_page.dart';
import 'package:language_learning_app/Screens/GrammerLearning/sub_lesson_page.dart';
import 'package:language_learning_app/Screens/LessonPage.dart';

class GrammarDetailPage extends StatelessWidget {
  final String category;
  final String learningtype;

  GrammarDetailPage({required this.category, required this.learningtype});

  @override
  Widget build(BuildContext context) {
    final subLessons = lessons[category] ?? {};

    return Scaffold(
      appBar: AppBar(title: Text(category), centerTitle: true),
      body: ListView(
        children:
            subLessons.keys.map((lessonTitle) {
              final details = subLessons[lessonTitle]!;

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  title: Text(
                    lessonTitle,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    if (details.containsKey("types")) {
                      // Go to SubLessonPage if lesson has nested types
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (_) => SubLessonPage(
                                quizCategory: learningtype,
                                title: lessonTitle,
                                types: Map<String, dynamic>.from(
                                  details["types"],
                                ),
                              ),
                        ),
                      );
                    } else {
                      // Go to GrammerLessonPage if it's a simple lesson
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (_) => GrammerLessonPage(
                                title: lessonTitle,
                                explanation: details["explanation"],
                                examples: List<String>.from(
                                  details["examples"],
                                ),
                              ),
                        ),
                      );
                    }
                  },
                ),
              );
            }).toList(),
      ),
    );
  }
}
