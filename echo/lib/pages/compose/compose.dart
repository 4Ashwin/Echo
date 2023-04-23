import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class ComposePage extends StatefulWidget {
  @override
  _ComposePageState createState() => _ComposePageState();
}

class _ComposePageState extends State<ComposePage> {
  final TextEditingController _welcomeTextController = TextEditingController(text: "Welcome to the Compose Page");
  final TextEditingController _userTextController = TextEditingController();
  final SpeechToText _speech = SpeechToText();
  bool _isListening = false;

  @override
  void initState() {
    super.initState();
    _initSpeechToText();
  }

  Future<void> _initSpeechToText() async {
    bool available = await _speech.initialize();
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
    });
    setState(() => _isListening = true);
  }

  void _stopListening() {
    _speech.stop();
    setState(() => _isListening = false);
  }

@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Compose Page"),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.centerRight,
                child: TextField(
                  controller: _welcomeTextController,
                  enabled: false,
                  maxLines: null, // allow the text to wrap
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: TextField(
                  controller: _userTextController,
                  maxLines: null, // allow the text to wrap
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Hi",
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _isListening ? _stopListening : _startListening,
        tooltip: _isListening ? 'Stop listening' : 'Start listening',
        child: Icon(_isListening ? Icons.mic : Icons.mic_none),
      ),
    );


  }
}
