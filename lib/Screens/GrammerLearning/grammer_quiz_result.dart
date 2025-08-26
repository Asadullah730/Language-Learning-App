import 'package:flutter/material.dart';
import 'package:language_learning_app/Screens/GrammerLearning/grammer_quiz.dart';
import 'package:language_learning_app/Screens/home.dart';
import 'package:percent_indicator/percent_indicator.dart'; // ✅ Add this package in pubspec.yaml

class QuizResultPage extends StatelessWidget {
  final int score;
  final int total;
  final String quizType;

  const QuizResultPage({
    super.key,
    required this.score,
    required this.total,
    required this.quizType,
  });

  @override
  Widget build(BuildContext context) {
    double percentage = (score / total) * 100;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Quiz Result"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 🎯 Circular Progress Indicator
              CircularPercentIndicator(
                radius: 100,
                lineWidth: 15,
                percent: percentage / 100,
                animation: true,
                animationDuration: 1200,
                center: Text(
                  "${percentage.toStringAsFixed(1)}%",
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
                progressColor:
                    percentage >= 50 ? Colors.green : Colors.redAccent,
                backgroundColor: Colors.grey.shade200,
                circularStrokeCap: CircularStrokeCap.round,
              ),
              const SizedBox(height: 30),

              // 🎯 Score text
              Text(
                quizType == "urdu" ? "آپ کا اسکور" : "Your Score",
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "$score / $total",
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),

              const SizedBox(height: 40),

              // 🎯 Try Again Button
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TakeQuizPage(quizType: quizType),
                    ),
                  );
                },
                icon: const Icon(Icons.replay, color: Colors.white),
                label: Text(
                  quizType == "urdu" ? "دوبارہ کوشش کریں" : "Try Again",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              const SizedBox(height: 15),

              // 🎯 Back to Home Button
              TextButton.icon(
                onPressed: () {
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                icon: const Icon(Icons.home, color: Colors.blueAccent),
                label: Text(
                  quizType == "urdu" ? "ہوم پر جائیں" : "Back to Home",
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.blueAccent,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
