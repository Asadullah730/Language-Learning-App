import 'dart:math';
import 'package:flutter/material.dart';
import 'package:language_learning_app/DataLayer/GrammerQuizes/english_quiz.dart';
import 'package:language_learning_app/DataLayer/GrammerQuizes/urdu_quiz.dart';
import 'package:language_learning_app/Screens/GrammerLearning/grammer_quiz_result.dart';

class TakeQuizPage extends StatefulWidget {
  final String quizType; // "english" or "urdu"

  const TakeQuizPage({required this.quizType, Key? key}) : super(key: key);

  @override
  _TakeQuizPageState createState() => _TakeQuizPageState();
}

class _TakeQuizPageState extends State<TakeQuizPage>
    with SingleTickerProviderStateMixin {
  int currentQuestionIndex = 0;
  int score = 0;
  bool answered = false;
  int? selectedIndex;

  late List<Map<String, dynamic>> questions; // ✅ store 10 random questions

  @override
  void initState() {
    super.initState();

    // ✅ Select quiz type
    final allQuestions =
        widget.quizType == "urdu" ? urduQuestions : englishQuestions;

    // ✅ Shuffle and pick 10 random questions
    allQuestions.shuffle(Random());
    questions = allQuestions.take(10).toList();
  }

  void checkAnswer(int index) {
    if (answered) return;

    setState(() {
      answered = true;
      selectedIndex = index;

      if (index == questions[currentQuestionIndex]["answer"]) {
        score++;
      }
    });

    Future.delayed(const Duration(seconds: 1), () {
      if (currentQuestionIndex < questions.length - 1) {
        setState(() {
          currentQuestionIndex++;
          answered = false;
          selectedIndex = null;
        });
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder:
                (_) => QuizResultPage(
                  score: score,
                  total: questions.length,
                  quizType: widget.quizType,
                ),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = questions[currentQuestionIndex];

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          widget.quizType == "urdu"
              ? "اردو گرامر کوئز"
              : "English Grammar Quiz",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF4A90E2), Color(0xFF007AFF)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // ✅ Progress bar with percentage
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Question ${currentQuestionIndex + 1} / ${questions.length}",
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    const SizedBox(height: 6),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: LinearProgressIndicator(
                        value: (currentQuestionIndex + 1) / questions.length,
                        backgroundColor: Colors.white24,
                        color: Colors.amber,
                        minHeight: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // ✅ Question Card
                Card(
                  elevation: 8,
                  shadowColor: Colors.black38,
                  color: Colors.white.withOpacity(0.9),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      currentQuestion["question"],
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // ✅ Options with animation
                ...List.generate(currentQuestion["options"].length, (index) {
                  final option = currentQuestion["options"][index];
                  final correctAnswer = currentQuestion["answer"];

                  Color cardColor = Colors.white.withOpacity(0.85);
                  IconData? iconData;
                  Color? iconColor;

                  if (answered) {
                    if (index == correctAnswer) {
                      cardColor = Colors.green.withOpacity(0.2);
                      iconData = Icons.check_circle;
                      iconColor = Colors.green;
                    } else if (index == selectedIndex) {
                      cardColor = Colors.red.withOpacity(0.2);
                      iconData = Icons.cancel;
                      iconColor = Colors.red;
                    }
                  }

                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 400),
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: Card(
                      color: cardColor,
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: ListTile(
                        title: Text(
                          option,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        trailing:
                            answered && iconData != null
                                ? Icon(iconData, color: iconColor)
                                : null,
                        onTap: () => checkAnswer(index),
                      ),
                    ),
                  );
                }),

                const Spacer(),

                // ✅ Score tracker with chip
                Center(
                  child: Chip(
                    label: Text(
                      "Score: $score / ${questions.length}",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    backgroundColor: Colors.black.withOpacity(0.3),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
