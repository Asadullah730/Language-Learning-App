import 'package:flutter/material.dart';

class QuizPage extends StatefulWidget {
  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final questions = [
    {
      "question": "What is the translation of 'Apple'?",
      "options": ["کتاب", "سیب", "سلام", "درخت"],
      "answer": "سیب",
    },
    {
      "question": "What is the translation of 'Hello'?",
      "options": ["خداحافظ", "سلام", "کتاب", "شکریہ"],
      "answer": "سلام",
    },
  ];

  int index = 0;
  int score = 0;

  void _checkAnswer(String option) {
    if (option == questions[index]["answer"]) {
      score++;
    }
    if (index < questions.length - 1) {
      setState(() => index++);
    } else {
      _showResult();
    }
  }

  void _showResult() {
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: const Text("Quiz Finished"),
            content: Text("Your score: $score/${questions.length}"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: const Text("OK"),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final q = questions[index];
    return Scaffold(
      appBar: AppBar(title: const Text("Quiz")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(q["question"] as String, style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 20),
            ...((q["options"] as List<String>).map((opt) {
              return ElevatedButton(
                onPressed: () => _checkAnswer(opt),
                child: Text(opt),
              );
            })),
          ],
        ),
      ),
    );
  }
}
