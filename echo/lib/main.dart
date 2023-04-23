import 'package:echo/pages/compose/compose.dart';
import 'package:echo/pages/registration/onboarding.dart';
import 'package:flutter/material.dart';
import 'package:echo/widgets/bottommenu.dart';

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
      home: ComposePage(),
    );
  }
}
