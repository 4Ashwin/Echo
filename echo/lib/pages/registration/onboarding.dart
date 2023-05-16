import 'package:echo/pages/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'dart:ui';
import '../../Provider/google_sign_in.dart';
import '../../constants.dart';
import '../../widgets/buttons/login_button.dart';
import 'package:flutter_tts/flutter_tts.dart';

FlutterTts _flutterTts = FlutterTts();
final TextEditingController _welcomeTextController =
    TextEditingController(text: "Welcome to the Echo");
void initState() {
  // super.initState();

  _flutterTts.speak(_welcomeTextController.text);
}

class onboarding extends StatelessWidget {
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
            SizedBox(
              height: 10,
            ),
            Text(
              'Echo',
              style: kHeaderTextStyle,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'voice based email for the blind .',
              style: kParaTextStyle,
            ),
            SizedBox(
              height: 100,
            ),
            LoginButton(
              image: 'images/google_logo.png',
              text: 'Sign In with Google',
              widget: Home(),
            ),
          ],
        ),
      ),
    );
  }
}
