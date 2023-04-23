import 'package:echo/widgets/buttons/commonButton.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:echo/widgets/bottommenu.dart';
import 'package:flutter/material.dart';

import 'package:flutter_tts/flutter_tts.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final TextEditingController _userTextController = TextEditingController();
  FlutterTts _flutterTts = FlutterTts();
  final TextEditingController _welcomeTextController =
      TextEditingController(text: "Welcome to the Settings Page");
  void initState() {
    super.initState();

    _flutterTts.speak(_welcomeTextController.text);
  }

  @override
  Widget build(BuildContext context) {
    void updateText(String text) {
      setState(() {
        _userTextController.text = text;
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Container(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CommonButton(text: 'Account Settings', widget: widget),
            CommonButton(text: 'Audio Control', widget: widget),
            CommonButton(text: 'Sound Control', widget: widget),
            CommonButton(text: 'Support', widget: widget),
          ],
        )),
      ),
      // bottomNavigationBar:
      //     BottomPanel(child: Container(), onTextUpdated: updateText),
    );
  }
}
