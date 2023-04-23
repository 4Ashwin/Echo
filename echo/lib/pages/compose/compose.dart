import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class ComposePage extends StatefulWidget {
  @override
  _ComposePageState createState() => _ComposePageState();
}

class _ComposePageState extends State<ComposePage> {
  final TextEditingController _welcomeTextController =
      TextEditingController(text: "You are in the Compose Email Page");
  final TextEditingController _userTextController = TextEditingController();
  final SpeechToText _speech = SpeechToText();
  bool _isListening = false;

  // initialize the _flutterTts variable
  FlutterTts _flutterTts = FlutterTts();

  @override
  void initState() {
    super.initState();
    _initSpeechToText();
  }

 Future<void> _initSpeechToText() async {
  bool available = await _speech.initialize();
  int flag=1;
  if (available) {
    setState(() => _isListening = false);
    if (flag == 1){
      _flutterTts.speak(_welcomeTextController.text);
      flag=0;
    }
  } else {
    print("Speech recognition not available");
  }
}

  void _startListening() {
    if (!_isListening) {
      _speech.listen(onResult: (SpeechRecognitionResult result) {
        setState(() {
          _userTextController.text = result.recognizedWords;
        });
        if (result.finalResult) {
          if (_userTextController.text.toLowerCase() == "quit") {
            _stopListening();
          } else {
            _speech.listen(onResult: (SpeechRecognitionResult result) {
              setState(() {
                _userTextController.text = result.recognizedWords;
              });
            });
          }
        }
      });
      setState(() => _isListening = true);
    }
  }

  void _stopListening() {
    _speech.stop();
    setState(() => _isListening = false);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Compose Page"),
      ),
      body: Container(
        width: width,
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                width: width,
                color: Colors.red,
                alignment: Alignment.centerRight,
                child: TextField(
                  controller: _welcomeTextController,
                  textAlign: TextAlign.end,
                  enabled: false,
                  // expands: true,
                  maxLines: null, // allow the text to wrap
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                  // _welcomeTextController.text,
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: TextField(
                  controller: _userTextController,
                  maxLines: null, // allow the text to wrap
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "User input will be shown here",
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
