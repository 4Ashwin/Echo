import 'package:echo/pages/registration/onboarding.dart';
import 'package:echo/widgets/bottommenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import '../../widgets/buttons/recorderButton.dart';
import '../home/home.dart';

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
  final TextEditingController _userTextController = TextEditingController();
  final TextEditingController _welcomeTextController = TextEditingController(
      text:
          "You are in the Compose Email Page.\nSay 'Begin' to start composing.\nSay 'Go Back' to go back to home page.");
  final SpeechToText _speech = SpeechToText();
  // final RecorderButton rb = RecorderButton();
  bool _isListening = false;
  FlutterTts _flutterTts = FlutterTts();
  List<ChatMessage> _chatMessages = [];
  List<String> questions = [
    "Please provide the receiver's email.",
    "Please provide the subject.",
    "Is there any greetings required?, example., Dear Sir/Ma'am",
    "Please provide the greetings.",
    "Please provide the body of the email.",
    "Is there any salutations required?, example., sincerely"
  ];
  List<String> responses = ['', '', '', '', '', ''];
  int currentQuestionIndex = -1;

  @override
  void initState() {
    super.initState();
    _flutterTts.speak(_welcomeTextController.text);
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

  void _addMessage(String message, bool isUserMessage) {
    setState(() {
      _chatMessages.add(ChatMessage(
        text: message,
        isUser: isUserMessage,
      ));
    });
  }

  Future<void> readResponses() async {
    //The timing needs to adjusted accordingly
    _flutterTts.speak("Here are the email details:");
    await Future.delayed(Duration(milliseconds: 1000));
    // Read the receiver email response
    String receiverEmail = responses[0];
    await Future.delayed(
        Duration(milliseconds: 2000)); // Delay before reading receiver email
    await _flutterTts.speak("Receiver email: $receiverEmail");

    // Read the subject
    String subject = responses[1];
    await Future.delayed(
        Duration(milliseconds: 4500)); // Delay before reading subject
    await _flutterTts.speak("Subject: $subject");
    await Future.delayed(Duration(milliseconds: 5000));
    // Read the remaining responses
    for (int i = 2; i < responses.length - 1; i++) {
      String response = responses[i];
      await _flutterTts.speak(response);

      // Calculate the delay based on the length of the response
      int delay = response.length * 260; // Adjust the multiplier as needed
      await Future.delayed(Duration(milliseconds: delay));
    }

    await _flutterTts.speak(responses[5]);
  }


  void _startListening() {
    if (!_isListening) {
      final _userTextController = TextEditingController();

      _speech.listen(onResult: (SpeechRecognitionResult result) {
        setState(() {
          _userTextController.text = result.recognizedWords;
        });
        if (result.finalResult) {
          if (currentQuestionIndex == -1) {
            if (_userTextController.text.toLowerCase() == "begin") {
              currentQuestionIndex = 0;
              String question = questions[currentQuestionIndex];
              _flutterTts.speak(question);
              _addMessage(question, false);
            } else if (_userTextController.text.toLowerCase() == "go back") {
             Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Home()), 
            );
            } else {
              _flutterTts.speak(
                  "Invalid command. Please say 'Begin' to start composing.");
              _addMessage(
                  "Invalid command. Please say 'Begin' to start composing.",
                  false);
            }
          } else if (currentQuestionIndex < questions.length) {
            String userInput = _userTextController.text;

            if (currentQuestionIndex == 2 &&
                (userInput.toLowerCase() == "no" ||
                    userInput.toLowerCase() == "now")) {
              // Skip storing the response for question 3 and its corresponding index
              currentQuestionIndex += 2;
            } else {
              responses[currentQuestionIndex] = userInput;
              _flutterTts.speak("User input received: $userInput");
              _addMessage(userInput, true);
              currentQuestionIndex++;
            }

            if (currentQuestionIndex == questions.length - 1 &&
                (userInput.toLowerCase() == "no" ||
                    userInput.toLowerCase() == "now")) {
              // Skip storing the response for the last question and its corresponding index
              currentQuestionIndex++;
            }

            if (currentQuestionIndex < questions.length) {
              String question = questions[currentQuestionIndex];
              _flutterTts.speak(question);
              _addMessage(question, false);
            } else {
              _flutterTts.speak("Email composition complete.");
              _addMessage("Email composition complete.", false);

              // Read out the responses
              readResponses();
            }
          }
          _userTextController.clear();
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
    void updateText(String text) {
      setState(() {
        _userTextController.text = text;
      });
    }

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
                                  ? TextAlign.left
                                  : TextAlign.right,
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
      // bottomNavigationBar:
      //       BottomPanel(child: Container(), onTextUpdated: updateText),
    );
  }
}
