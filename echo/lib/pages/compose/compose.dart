import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class ComposePage extends StatefulWidget {
  @override
  _ComposePageState createState() => _ComposePageState();
}

class ChatMessage {
  String text;
  bool isUser;

  ChatMessage({required this.text, required this.isUser});
}

class _ComposePageState extends State<ComposePage> {
  final TextEditingController _welcomeTextController =
      TextEditingController(text: "You are in the Compose Email Page");
  final SpeechToText _speech = SpeechToText();
  bool _isListening = false;
  FlutterTts _flutterTts = FlutterTts();
  List<ChatMessage> _chatMessages = [];

  @override
  void initState() {
    super.initState();
    _initSpeechToText();
    _flutterTts.speak(_welcomeTextController.text);
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
    if (!_isListening) {
      final _userTextController = TextEditingController();
      String sentence = '';
      _speech.listen(onResult: (SpeechRecognitionResult result) {
        setState(() {
          _userTextController.text = result.recognizedWords;
        });
        if (result.finalResult) {
          if (_userTextController.text.toLowerCase() == "quit") {
            _stopListening();
          } else {
            sentence += _userTextController.text + ' ';
            _addMessage(sentence.trim(), false);
            sentence = '';
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

  void _addMessage(String message, bool isBotMessage) {
    setState(() {
      _chatMessages.add(ChatMessage(
        text: message,
        isUser: isBotMessage,
      ));
    });
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
        child: Column(
          children: [
            Container(
              width: width,
              alignment: Alignment.centerRight,
              child: TextField(
                controller: _welcomeTextController,
                textAlign: TextAlign.end,
                enabled: false,
                maxLines: null,
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _chatMessages.length,
                itemBuilder: (BuildContext context, int index) {
                  final message = _chatMessages[index];
                  return ListTile(
                    subtitle: Container(
                      alignment: message.isUser
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Text(
                        _chatMessages[index].text,
                        textAlign:
                            message.isUser ? TextAlign.right : TextAlign.left,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
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
