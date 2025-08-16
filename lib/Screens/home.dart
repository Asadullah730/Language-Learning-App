import 'package:flutter/material.dart';
import 'package:language_learning_app/Screens/LessonPage.dart';
import 'package:language_learning_app/Screens/quizpage.dart';

class HomePage extends StatelessWidget {
  final categories = ["Vocabulary", "Grammar", "Phrases"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Language Learning App")),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: categories.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              if (categories[index] == "Vocabulary") {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => LessonPage()),
                );
              } else if (categories[index] == "Grammar") {
                // Future page
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => QuizPage()),
                );
              }
            },
            child: Card(
              color: Colors.blue.shade100,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Text(
                  categories[index],
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
