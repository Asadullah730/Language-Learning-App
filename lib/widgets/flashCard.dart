import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:language_learning_app/Model/word.dart';

class Flashcard extends StatefulWidget {
  final Word word;
  const Flashcard({super.key, required this.word});

  @override
  State<Flashcard> createState() => _FlashcardState();
}

class _FlashcardState extends State<Flashcard> {
  final GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    // Auto-flip every 3 seconds
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      cardKey.currentState?.toggleCard();
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // stop timer when widget is removed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      width: 250,
      child: FlipCard(
        key: cardKey,
        flipOnTouch: true, // allow manual tap too
        direction: FlipDirection.HORIZONTAL,
        front: Card(
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              children: [
                // Image
                SizedBox(
                  height: double.infinity,
                  width: double.infinity,
                  child: Image.network(widget.word.imageUrl, fit: BoxFit.cover),
                ),
                // Dark overlay
                Container(color: Colors.black.withOpacity(0.2)),
                // Word text centered
                Positioned(
                  bottom: 20,
                  left: 100,
                  child: Center(
                    child: Text(
                      widget.word.text,
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            blurRadius: 10,
                            color: Colors.black,
                            offset: Offset(2, 2),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // Back side
        back: Card(
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          color: Colors.blueGrey[50],
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.word.text,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  "Translation: ${widget.word.translation}",
                  style: const TextStyle(fontSize: 22, color: Colors.black87),
                ),
                const SizedBox(height: 12),
                Text(
                  "Pronunciation: ${widget.word.pronunciation}",
                  style: const TextStyle(fontSize: 20, color: Colors.black54),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
