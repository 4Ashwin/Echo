import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

import 'package:echo/widgets/buttons/commonButton.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final TextEditingController _userTextController = TextEditingController();
  FlutterTts _flutterTts = FlutterTts();
  final TextEditingController _welcomeTextController =
      TextEditingController(text: "Welcome to the Settings Page");

  double _speechSpeed = 1.0; // Speech speed value

  @override
  void initState() {
    super.initState();

    _flutterTts.speak(_welcomeTextController.text);
  }

  @override
  void dispose() {
    _flutterTts.stop();
    //_flutterTts.shutdown();
    super.dispose();
  }

  void updateText(String text) {
    setState(() {
      _userTextController.text = text;
    });
  }

  void setSpeechSpeed(double speed) {
    setState(() {
      _speechSpeed = speed;
    });
    _flutterTts.setSpeechRate(speed);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => setSpeechSpeed(0.5), // Low speech speed
                    child: const Text('Low'),
                  ),
                  ElevatedButton(
                    onPressed: () => setSpeechSpeed(1.0), // Medium speech speed
                    child: const Text('Medium'),
                  ),
                  ElevatedButton(
                    onPressed: () => setSpeechSpeed(1.25), // High speech speed
                    child: const Text('High'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                'Speech Speed: $_speechSpeed',
                style: const TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
