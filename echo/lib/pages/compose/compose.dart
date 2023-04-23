import 'package:echo/pages/registration/onboarding.dart';
import 'package:echo/widgets/bottommenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import '../../widgets/buttons/recorderButton.dart';

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
      TextEditingController(text: "Welcome to the Compose Page");
  final TextEditingController _userTextController = TextEditingController();

  // TextEditingController(text: "You are in the Compose Email Page");
  final SpeechToText _speech = SpeechToText();
  // final RecorderButton rb = RecorderButton();
  bool _isListening = false;
  FlutterTts _flutterTts = FlutterTts();
  List<ChatMessage> _chatMessages = [];

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

  void _addMessage(String message, bool isUserMessage) {
    setState(() {
      _chatMessages.add(ChatMessage(
        text: message,
        isUser: isUserMessage,
      ));
    });
  }

  void _startListening() {
    if (!_isListening) {
      final _userTextController = TextEditingController();
      _speech.listen(onResult: (SpeechRecognitionResult result) {
        setState(() {
          _userTextController.text = result.recognizedWords;
        });
        if (result.finalResult) {
          if (_userTextController.text.toLowerCase() == "quit") {
            _stopListening();
          } else {
            _flutterTts
                .speak("User input received: ${_userTextController.text}");
            _addMessage(_userTextController.text, true);
            _addMessage("User input received: ${_userTextController.text}",
                false); // new line
            _userTextController.clear();
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

  // void _addMessage(String message, bool isUserMessage) {
  //   setState(() {
  //     _chatMessages.add(ChatMessage(
  //       text: message,
  //       isUser: isUserMessage,
  //     ));
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Compose Page"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Container(
          width: width,
          child: Column(
            children: [
              Container(
                width: width,
                alignment: Alignment.centerLeft,
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
                    return Container(
                      color: Colors.green[100],
                      child: ListTile(
                        trailing: !message.isUser
                            ? CircleAvatar(
                                child: Text(
                                  "E",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                backgroundColor: Colors.green,
                              )
                            : null,
                        leading: message.isUser
                            ? CircleAvatar(
                                child: Text(
                                  "U",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                backgroundColor: Colors.blue,
                              )
                            : null,
                        title: Container(
                          alignment: message.isUser
                              ? Alignment.centerLeft
                              : Alignment.centerRight,
                          child: Container(
                            width: width / 2,
                            child: Text(
                              _chatMessages[index].text,
                              textAlign: message.isUser
                                  ? TextAlign.right
                                  : TextAlign.left,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
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
