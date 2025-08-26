import 'package:flutter/material.dart';

class TakeQuizPage extends StatefulWidget {
  final String quizType; // "english" or "urdu"

  const TakeQuizPage({required this.quizType, Key? key}) : super(key: key);

  @override
  _TakeQuizPageState createState() => _TakeQuizPageState();
}

class _TakeQuizPageState extends State<TakeQuizPage> {
  int currentQuestionIndex = 0;
  int score = 0;
  bool answered = false;
  int? selectedIndex;

  // English Grammar Quiz
  final List<Map<String, dynamic>> englishQuestions = [
    {
      "question": "Which is a Noun?",
      "options": ["Run", "Beautiful", "Book", "Quickly"],
      "answer": 2,
    },
    {
      "question": "Which is a Verb?",
      "options": ["Apple", "Eat", "Green", "Slow"],
      "answer": 1,
    },
    {
      "question": "Which is an Adjective?",
      "options": ["Fast", "Dog", "Sing", "Quickly"],
      "answer": 0,
    },
    {
      "question": "Which is an Adverb?",
      "options": ["Happy", "Slowly", "House", "Play"],
      "answer": 1,
    },
  ];

  // Urdu Grammar Quiz
  final List<Map<String, dynamic>> urduQuestions = [
    {
      "question": "اسم کس کو کہتے ہیں؟",
      "options": ["کام", "خوبصورت", "کتاب", "جلدی"],
      "answer": 2,
    },
    {
      "question": "فعل کس کو کہتے ہیں؟",
      "options": ["سیب", "کھانا", "سبز", "آہستہ"],
      "answer": 1,
    },
    {
      "question": "صفت کس کو کہتے ہیں؟",
      "options": ["تیز", "کتا", "گانا", "جلدی"],
      "answer": 0,
    },
    {
      "question": "حال کس کو کہتے ہیں؟",
      "options": ["خوش", "آہستہ آہستہ", "گھر", "کھیلنا"],
      "answer": 1,
    },
  ];

  void checkAnswer(int index, List<Map<String, dynamic>> questions) {
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
        showDialog(
          context: context,
          builder:
              (_) => AlertDialog(
                title: const Text("Quiz Finished!"),
                content: Text("Your score: $score / ${questions.length}"),
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
    });
  }

  @override
  Widget build(BuildContext context) {
    final questions =
        widget.quizType == "urdu" ? urduQuestions : englishQuestions;

    final currentQuestion = questions[currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.quizType == "urdu"
              ? "اردو گرامر کوئز"
              : "English Grammar Quiz",
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // ✅ Progress bar
            LinearProgressIndicator(
              value: (currentQuestionIndex + 1) / questions.length,
              backgroundColor: Colors.grey[300],
              color: Colors.blue,
              minHeight: 8,
            ),
            const SizedBox(height: 20),

            // Question text
            Text(
              currentQuestion["question"],
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

            // Options
            ...List.generate(currentQuestion["options"].length, (index) {
              final option = currentQuestion["options"][index];
              final correctAnswer = currentQuestion["answer"];

              Color? optionColor;
              IconData? iconData;

              if (answered) {
                if (index == correctAnswer) {
                  optionColor = Colors.green[100];
                  iconData = Icons.check_circle;
                } else if (index == selectedIndex) {
                  optionColor = Colors.red[100];
                  iconData = Icons.cancel;
                }
              }

              return Card(
                color: optionColor,
                child: ListTile(
                  title: Text(option),
                  trailing:
                      answered && iconData != null
                          ? Icon(
                            iconData,
                            color:
                                index == correctAnswer
                                    ? Colors.green
                                    : Colors.red,
                          )
                          : null,
                  onTap: () => checkAnswer(index, questions),
                ),
              );
            }),

            const Spacer(),

            // Score tracker
            Text(
              "Score: $score / ${questions.length}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
