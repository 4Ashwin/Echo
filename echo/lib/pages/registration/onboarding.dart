import 'package:echo/pages/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'dart:ui';

import '../../constants.dart';
import '../../widgets/buttons/login_button.dart';

class onboarding extends StatelessWidget {
  const onboarding({super.key});

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
