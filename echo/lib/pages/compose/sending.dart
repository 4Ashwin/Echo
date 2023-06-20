import 'package:echo/widgets/bottommenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class SendingPage extends StatefulWidget {
  final String emailContent;

  SendingPage({required this.emailContent});

  @override
  State<SendingPage> createState() => _SendingPageState();
}

class _SendingPageState extends State<SendingPage> {
  final TextEditingController _userTextController = TextEditingController();
  final FlutterTts _flutterTts = FlutterTts();

  @override
  void dispose() {
    _flutterTts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void updateText(String text) {
      setState(() {
        _userTextController.text = text;
      });
    }

    Future<void> readEmailContent() async {

      _flutterTts.speak(widget.emailContent);
      _flutterTts.speak('Do you wish to send this email?');
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Email Content'),
      ),
      body: GestureDetector(
        onTap: readEmailContent,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(widget.emailContent),
          ),
        ),
      ),
      bottomNavigationBar: BottomPanel(child: Container(), onTextUpdated: updateText),
    );
  }
}
