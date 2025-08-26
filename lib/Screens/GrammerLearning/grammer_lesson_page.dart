import 'package:flutter/material.dart';

class GrammerLessonPage extends StatelessWidget {
  final String title;
  final String explanation;
  final List<String> examples;

  GrammerLessonPage({
    required this.title,
    required this.explanation,
    required this.examples,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child:
            title == "Tenses"
                ? ListView(
                  children: [
                    Text(
                      "Tenses Overview",
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(explanation, style: const TextStyle(fontSize: 18)),
                    const SizedBox(height: 20),

                    Center(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Tenses Quiz Coming Soon!"),
                            ),
                          );
                        },
                        icon: const Icon(Icons.quiz),
                        label: const Text("Take Quiz"),
                      ),
                    ),
                  ],
                )
                : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(explanation, style: const TextStyle(fontSize: 18)),
                    const SizedBox(height: 20),
                    const Text(
                      "Examples:",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ...examples.map(
                      (e) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Text(
                          "• $e",
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
      ),
    );
  }
}
