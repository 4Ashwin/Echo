import 'package:echo/pages/compose/compose.dart';
import 'package:echo/pages/draft/draft.dart';
import 'package:echo/pages/home/home.dart';
import 'package:echo/pages/read/read.dart';
import 'package:echo/pages/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:flutter_tts/flutter_tts.dart';

class RecorderButton extends StatefulWidget {
  final void Function(String) onTextUpdated;

  const RecorderButton({required this.onTextUpdated});

  @override
  State<RecorderButton> createState() => _RecorderButtonState();
}

class ChatMessage {
  String text;
  bool isUser;

  ChatMessage({required this.text, required this.isUser});
}

class _RecorderButtonState extends State<RecorderButton> {
  final TextEditingController _userTextController = TextEditingController();
  final SpeechToText _speech = SpeechToText();
  bool _isListening = false;
  FlutterTts _flutterTts = FlutterTts();
  List<ChatMessage> _chatMessages = [];
  // final String text = 'ashwin';
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

  void _addMessage(String message, bool isUserMessage) {
    setState(() {
      _chatMessages.add(ChatMessage(
        text: message,
        isUser: isUserMessage,
      ));
    });
  }

  void _startListening() {
    _speech.listen(onResult: (SpeechRecognitionResult result) {
      setState(() {
        _userTextController.text = result.recognizedWords;
      });
      widget.onTextUpdated(result.recognizedWords);

      if (result.finalResult) {
        var input = _userTextController.text.toLowerCase();
        if (_userTextController.text.toLowerCase() == "quit") {
          _stopListening();
        } else {
          
          _flutterTts.speak("User input received : ${_userTextController.text}");
          _addMessage(_userTextController.text, true);
          _addMessage("User input received: ${_userTextController.text}",
              false); // new line
          if(input=="echo combos"||input=="echo combo"||input=="combo"||input=="eco combo"||input=="echo compose"||input=="compose"||input=="combos"||input=="compose email" ||input=="email compose")
          {
            Navigator.push(context,MaterialPageRoute(builder: (context) =>ComposePage()));
          }
          else if(input=="draft"||input=="echo draft"||input=="eco draft" ||input=="draft email")
          {
            Navigator.push(context,MaterialPageRoute(builder: (context) =>DraftPage()));
          }
          else if(input=="inbox"||input=="echo inbox"||input=="eco inbox" ||input=="read email")
          {
            Navigator.push(context,MaterialPageRoute(builder: (context) =>ReadPage()));
          }
          else if(input=="settings"||input=="setting"||input=="eco settings" ||input=="echo setting"||input=="echo settings")
          {
            Navigator.push(context,MaterialPageRoute(builder: (context) =>Settings()));
          }
          else if(input=="echo home"||input=="home"||input=="eco home" ||input=="home page")
          {
            Navigator.push(context,MaterialPageRoute(builder: (context) =>Home()));
          }
          else if(input=="exit"||input=="echo back" ||input=="eco back"||input=="eco go back"||input=="ecoback")
          {
            Navigator.push(context,MaterialPageRoute(builder: (context) =>Home()));
            
            // Navigator.pop(context);
          }
          _userTextController.clear();
        }
      } // Call the callback function
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
