import 'package:echo/pages/home/home.dart';
import 'package:echo/pages/registration/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'dart:ui';
import '../../Provider/google_sign_in.dart';
import '../../constants.dart';
import '../../widgets/buttons/login_button.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

FlutterTts _flutterTts = FlutterTts();
stt.SpeechToText _speechToText = stt.SpeechToText();

class onboarding extends StatefulWidget {
  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<onboarding> {
  bool _isListening = false;

  @override
  void initState() {
    super.initState();
    _speakWelcomeMessage();
    _listen();
    _isListening = false; 
  }

  @override
  void dispose() {
    _speechToText.stop();
    super.dispose();
  }

  void _speakWelcomeMessage() async {
    await _flutterTts.speak(
      'Welcome to Echo, your voice-based email assistant. Say "Gmail login" to select a Gmail account. Say "Exit" to exit the app.',
    );
    await _flutterTts.setLanguage('en-US');
    await _flutterTts.setPitch(1);
    await _flutterTts.setSpeechRate(0.5);
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speechToText.initialize();
      if (available) {
        setState(() {
          _isListening = true;
        });
        _speechToText.listen(
          onResult: (result) {
            String spokenText = result.recognizedWords.toLowerCase();
            _processUserInput(spokenText);
          },
        );
      }
    } else {
      _speechToText.stop();
      setState(() {
        _isListening = false;
      });
    }
  }

  void _processUserInput(String input) {
    // if (input.contains('gmail') || input.contains('login')) {
       if (input.contains('login')) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Profile()),
      );
    } else if (input.contains('exit')) {
      // Close the app
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Echo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Image(
                image: AssetImage('images/logo2.png'),
                width: 100,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Echo',
              style: kHeaderTextStyle,
            ),
            SizedBox(height: 10),
            Text(
              'Voice-based email for the blind.',
              style: kParaTextStyle,
            ),
            SizedBox(height: 100),
            LoginButton(
              image: 'images/google_logo.png',
              text: 'Sign In with Google',
              widget: Profile(),
            ),
          ],
          
        ),
        
      ),
     
     floatingActionButton: FloatingActionButton(
  onPressed: _listen,
  child: Icon(_isListening ? Icons.mic_none : Icons.mic),
  backgroundColor: _isListening ? Colors.red : Colors.blue,
),

    );
  }
}