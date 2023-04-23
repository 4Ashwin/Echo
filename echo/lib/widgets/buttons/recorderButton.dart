import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class RecorderButton extends StatefulWidget {
  final void Function(String) onTextUpdated;

  const RecorderButton({required this.onTextUpdated});

  @override
  State<RecorderButton> createState() => _RecorderButtonState();
}

class _RecorderButtonState extends State<RecorderButton> {
  final TextEditingController _userTextController = TextEditingController();
  final SpeechToText _speech = SpeechToText();
  bool _isListening = false;
  final String text = 'ashwin';
  @override
  void initState() {
    super.initState();
    _initSpeechToText();
  }

  Future<void> _initSpeechToText() async {
    bool available = await _speech.initialize();
    var texts = _userTextController.text;

    if (available) {
      setState(() => _isListening = false);
    } else {
      print("Speech recognition not available");
    }
  }

  void _startListening() {
    _speech.listen(onResult: (SpeechRecognitionResult result) {
      setState(() {
        _userTextController.text = result.recognizedWords;
      });
      widget
          .onTextUpdated(result.recognizedWords); // Call the callback function
    });
    setState(() => _isListening = true);
  }

  void _stopListening() {
    _speech.stop();
    setState(() => _isListening = false);
  }

  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: _isListening ? _stopListening : _startListening,
      tooltip: _isListening ? 'Stop listening' : 'Start listening',
      child: Icon(_isListening ? Icons.mic : Icons.mic_none),
    );
  }
}
