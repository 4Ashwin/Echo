import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import '../../widgets/recorderButton.dart';

class ComposePage extends StatefulWidget {
  @override
  _ComposePageState createState() => _ComposePageState();
}

class _ComposePageState extends State<ComposePage> {
  final TextEditingController _welcomeTextController =
      TextEditingController(text: "Welcome to the Compose Page");
  final TextEditingController _userTextController = TextEditingController();

  final SpeechToText _speech = SpeechToText();
  // final RecorderButton rb = RecorderButton();
  bool _isListening = false;

  @override
  Widget build(BuildContext context) {
    void updateText(String text) {
      setState(() {
        _userTextController.text = text;
      });
    }

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
                  enabled: false,
                  maxLines: null, // allow the text to wrap
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                ),
              ),
              RecorderButton(onTextUpdated: updateText),
            ],
          ),
        ),
      ),
    );
  }
}
