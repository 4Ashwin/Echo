import 'package:echo/constants/constants.dart';
import 'package:echo/pages/registration/onboarding.dart';
import 'package:echo/widgets/bottommenu.dart';
import 'package:flutter/gestures.dart';
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
  bool emailSent = false;

  // final RecorderButton rb = RecorderButton();
  bool _isListening = false;
  FlutterTts _flutterTts = FlutterTts();
  List<ChatMessage> _chatMessages = [];
  List<String> questions = [
    "Please provide the username of the recipient email address.",
    "Please provide the mail server of the recipient email.",
    "Please provide the subject.",
    "Is there any greetings required?, example., Dear Sir / Ma'am. Say yes or no",
    "Please provide the greetings.",
    "Please provide the body of the email.",
    "Is there any salutations required?, example., sincerely"
  ];

  List<String> responses = ['', '', '', '', '', '', ''];
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

  Future<void> showEmailDataDialog(String emailContent) async {
    await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async {
            await _handleDialogClose();
            return true;
          },
          child: AlertDialog(
            title: Text('Email Content'),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(emailContent),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Close'),
                onPressed: _handleDialogClose,
              ),
            ],
          ),
        );
      },
    );
  }



Future<void> _handleDialogClose() async {
  Navigator.of(context).pop();
  await _flutterTts.awaitSpeakCompletion(true);
  _flutterTts.speak('Do you wish to send this email?');

  // Use a GestureRecognizer to detect taps on different parts of the screen
  TapGestureRecognizer _tapGestureRecognizer = TapGestureRecognizer()
    ..onTapUp = (TapUpDetails details) {
      // Get the vertical position of the tap
      double screenHeight = MediaQuery.of(context).size.height;
      double tapPosition = details.localPosition.dy;

      // Calculate the threshold to divide the screen into two parts
      double threshold = screenHeight / 2;

      if (tapPosition < threshold) {
        // Top part of the screen tapped
        print('Send email');
        // Call your logic to send the email here
      } else {
        // Bottom part of the screen tapped
        print('Discard email');
        // Handle discarding the email here
      }
    };

  // Attach the GestureRecognizer to the root widget using a GestureDetector
  await showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return WillPopScope(
        onWillPop: () async {
          _tapGestureRecognizer.dispose(); // Dispose of the GestureRecognizer
          return true;
        },
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTapUp: _tapGestureRecognizer.onTapUp,
        ),
      );
    },
  );
}


  void sendEmail() {
    print('Sending Email:');
    for (int i = 0; i < responses.length; i++) {
      print('Question ${i + 1}: ${responses[i]}');
    }

    // Simulate sending email by adding a delay
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        // Set a flag to indicate that the email has been sent successfully
        emailSent = true;
      });
    });
  }

  Future<void> readResponses() async {
    await Future.delayed(Duration(milliseconds: 3000));
    _flutterTts.speak("Here are the email details:");
    await Future.delayed(Duration(milliseconds: 3000));

    // Read the receiver email response
    String receiverEmail = responses[0];
    String re = responses[1];
    List<String> emailData = [];

    // Append the modified responses to email_data
    String firstResponse =
        "$receiverEmail@$re.com".replaceAll(' ', '').toLowerCase();
    emailData.add(firstResponse);

    for (int i = 2; i < responses.length; i++) {
      emailData.add(responses[i]);
    }
    Constants.Data_to_send = List.from(emailData);
    String emailContent = "Receiver email: ${emailData[0]}\n"
        "Subject: ${emailData[1]}\n\n";

    for (int i = 3; i < emailData.length; i++) {
      emailContent += "${emailData[i]}\n";
    }
    emailContent += Constants.nameuser;

    await readEmailContent(emailContent);
  }

  Future<void> readEmailContent(String emailContent) async {
    await _flutterTts.speak("Tap anywhere on the screen to close reading.");
    _flutterTts.speak(emailContent);
    showEmailDataDialog(emailContent);
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

            if (currentQuestionIndex == 3 &&
                (userInput.toLowerCase() == "no" ||
                    userInput.toLowerCase() == "now")) {
              // Skip storing the response for question 4 and its corresponding index
              currentQuestionIndex += 2;
            } else {
              responses[currentQuestionIndex] = userInput;
              // _flutterTts.speak("User input received: $userInput");
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

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text('Compose Page'),
            if (emailSent)
              Icon(
                Icons.check,
                color: Colors.green,
              ),
          ],
        ),
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
                  style: TextStyle(color: Colors.black),
                  textAlign: TextAlign.end,
                  enabled: false,
                  maxLines: null,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                ),
              ),
              Expanded(
                child: ListView(
                  children: _chatMessages.map((message) {
                    return ListTile(
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
                            message.text,
                            textAlign: message.isUser
                                ? TextAlign.left
                                : TextAlign.right,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
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
