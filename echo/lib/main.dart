import 'package:echo/pages/registration/onboarding.dart';
import 'package:echo/widgets/speechtotext.dart';
import 'package:flutter/material.dart';
import 'package:echo/widgets/bottommenu.dart';
import 'package:speech_to_text/speech_to_text.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Bottom Panel Demo'),
        ),
        body: BottomPanel(
          child: Container(
            color: Colors.blue,
            child: Center(
              child: Text('This is the main content'),
            ),
          ),
        ),
      ),
      
      
      //home:SpeechSampleApp(),
    );
  }
}