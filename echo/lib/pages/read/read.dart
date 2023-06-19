import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:echo/widgets/bottommenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../../widgets/recentMails.dart';

class ReadPage extends StatefulWidget {
  const ReadPage({super.key});

  @override
  State<ReadPage> createState() => _ReadPageState();
}

class _ReadPageState extends State<ReadPage> {
  final TextEditingController _userTextController = TextEditingController();
  FlutterTts _flutterTts = FlutterTts();
  final TextEditingController _welcomeTextController =
      TextEditingController(text: "Welcome to the Inbox Page");
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
        title: Text('Inbox'),
      ),
      body: Container(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Recent mails',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'View All',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
          ),
              Expanded(
                child: RecentMails(),
              )
        ],
      )),
      bottomNavigationBar:
          BottomPanel(child: Container(), onTextUpdated: updateText),
    );
  }
}
