import 'package:echo/pages/compose/compose.dart';
import 'package:echo/pages/home/home.dart';
import 'package:echo/pages/registration/onboarding.dart';
import 'package:flutter/material.dart';
import 'package:echo/widgets/bottommenu.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
//     FlutterTts _flutterTts = FlutterTts();
//   final TextEditingController _welcomeTextController =
//       TextEditingController(text: "Welcome to the Echo");
// void initState() {
//       super.initState();

//       _flutterTts.speak(_welcomeTextController.text);
//     }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: Color(0xffEAE7F0),
      ),
      home: onboarding(),
    );
  }
}
