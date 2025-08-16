import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:language_learning_app/Model/word.dart';
import 'package:language_learning_app/widgets/flashCard.dart';

class LessonPage extends StatefulWidget {
  @override
  State<LessonPage> createState() => _LessonPageState();
}

class _LessonPageState extends State<LessonPage> {
  final List<Word> words = [
    Word(text: "Apple", translation: "سیب", pronunciation: "Apple"),
    Word(text: "Book", translation: "کتاب", pronunciation: "Book"),
    Word(text: "Hello", translation: "سلام", pronunciation: "Hello"),
  ];

  int index = 0;
  final FlutterTts tts = FlutterTts();

  void _nextCard() {
    setState(() {
      index = (index + 1) % words.length;
    });
  }

  @override
  void dispose() {
    tts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(title: const Text("Daily Lesson")),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Flashcard
                  SizedBox(
                    width: size.width * 0.9,
                    height: size.height * 0.3,
                    child: Flashcard(word: words[index]),
                  ),
                  const SizedBox(height: 20),

                  // Next button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _nextCard,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: Text(
                        "Next",
                        style: TextStyle(fontSize: size.width * 0.045),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Speak English word
                  IconButton(
                    iconSize: size.width * 0.1,
                    icon: const Icon(Icons.volume_up),
                    onPressed: () async {
                      await tts.setLanguage("en-US"); // English
                      await tts.setPitch(1.2);
                      await tts.setSpeechRate(0.5);
                      await tts.setVolume(1);

                      await tts.speak(words[index].text);
                    },
                  ),

                  const SizedBox(height: 20),

                  // Speak Translation
                  ElevatedButton(
                    onPressed: () async {
                      await tts.setLanguage("ur-PK"); // Urdu (Pakistan)
                      await tts.setPitch(1.2);
                      await tts.setSpeechRate(0.5);
                      await tts.setVolume(1);

                      await tts.speak(words[index].translation);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.volume_up),
                        const SizedBox(width: 10),
                        Text(
                          "Pronounce Translation",
                          style: TextStyle(fontSize: size.width * 0.045),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
