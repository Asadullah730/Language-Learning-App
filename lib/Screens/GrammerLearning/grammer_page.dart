import 'package:flutter/material.dart';
import 'package:language_learning_app/Screens/GrammerLearning/grammer_detailed_page.dart';

class GrammarPage extends StatelessWidget {
  final List<String> grammarCategories = [
    "English Grammar",
    "Urdu Grammar",
    "Spanish Grammar",
    "French Grammar",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Grammar Learning"), centerTitle: true),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: grammarCategories.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (_) => GrammarDetailPage(
                        category: grammarCategories[index],
                        learningtype:
                            grammarCategories[index] == "English Grammar"
                                ? "english"
                                : "urdu",
                      ),
                ),
              );
            },
            child: Card(
              color: Colors.green.shade100,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Text(
                  grammarCategories[index],
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18,
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
