import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class SpeechSearchField extends StatefulWidget {
  const SpeechSearchField({super.key});

  @override
  State<SpeechSearchField> createState() => _SpeechSearchFieldState();
}

class _SpeechSearchFieldState extends State<SpeechSearchField>
    with SingleTickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  late stt.SpeechToText _speech;
  bool _isListening = false;
  bool _speechAvailable = false;

  late AnimationController _animationController;

  // List of colors for dynamic ripple
  final List<Color> _rippleColors = [
    Colors.blue,
    Colors.grey,
    Colors.green,
    Colors.green,
    Colors.blue,
    Colors.indigo,
    Colors.purple,
  ];

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
    _initSpeech();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _speech.stop();
    super.dispose();
  }

  Future<void> _initSpeech() async {
    PermissionStatus status = await Permission.microphone.request();
    if (!status.isGranted) {
      if (kDebugMode) print("Microphone permission denied");
      return;
    }

    _speechAvailable = await _speech.initialize(
      onStatus: (status) {
        if (kDebugMode) print("Speech Status: $status");
        if (status == 'done' || status == 'notListening') {
          setState(() => _isListening = false); // Automatically stop
        }
      },
      onError: (error) => print("Speech Error: $error"),
    );

    if (kDebugMode) print("Speech Available: $_speechAvailable");
    setState(() {});
  }

  void _listen() async {
    if (!_speechAvailable) {
      if (kDebugMode) print("Speech not available. Reinitializing...");
      await _initSpeech();
      return;
    }

    if (!_isListening) {
      bool hasPermission = await Permission.microphone.isGranted;
      if (!hasPermission) {
        if (kDebugMode) print("Microphone permission not granted");
        return;
      }

      setState(() => _isListening = true);
      _speech.listen(
        onResult: (result) {
          setState(() {
            _searchController.text = result.recognizedWords;
            _searchController.selection = TextSelection.fromPosition(
              TextPosition(offset: _searchController.text.length),
            );
          });
          if (kDebugMode) print("Recognized Words: ${result.recognizedWords}");
        },
        listenMode: stt.ListenMode.dictation,
        localeId: 'en_US',
      );
      if (kDebugMode) print("Started Listening...");
    } else {
      setState(() => _isListening = false);
      _speech.stop();
      if (kDebugMode) print("Stopped Listening...");
    }
  }

  Color _getDynamicColor(double progress, int index) {
    int colorIndex =
        ((progress * _rippleColors.length + index) % _rippleColors.length)
            .toInt();
    return _rippleColors[colorIndex];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Speech To Text"), centerTitle: true),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _searchController,
                decoration: const InputDecoration(hintText: "Please Speak..."),
              ),
              const SizedBox(height: 40),
              Stack(
                alignment: Alignment.center,
                children: [
                  // Dynamic colored ripple animation
                  for (int i = 0; i < 3; i++)
                    AnimatedBuilder(
                      animation: _animationController,
                      builder: (context, child) {
                        double progress =
                            (_animationController.value + i * 0.2) % 1;
                        double size = 80 + (progress * 60);
                        double opacity = _isListening ? 1 - progress : 0;
                        return Container(
                          width: size,
                          height: size,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _getDynamicColor(
                              progress,
                              i,
                            ).withOpacity(opacity * 0.5),
                          ),
                        );
                      },
                    ),
                  // Mic Button with scaling and glow effect
                  AnimatedScale(
                    scale: _isListening ? 1.2 : 1.0,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow:
                            _isListening
                                ? [
                                  BoxShadow(
                                    color: Colors.red.withOpacity(0.6),
                                    blurRadius: 20,
                                    spreadRadius: 5,
                                  ),
                                ]
                                : [],
                      ),
                      child: FloatingActionButton(
                        backgroundColor:
                            _isListening ? Colors.red : Colors.black,
                        onPressed: _listen,
                        child: Icon(
                          _isListening ? Icons.mic : Icons.mic_none,
                          size: 32,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
