import 'package:echo/widgets/recentDrafts.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:echo/widgets/bottommenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../../widgets/recentMails.dart';

class DraftPage extends StatefulWidget {
  const DraftPage({super.key});

  @override
  State<DraftPage> createState() => _DraftPageState();
}

class _DraftPageState extends State<DraftPage> {
  final TextEditingController _userTextController = TextEditingController();

  FlutterTts _flutterTts = FlutterTts();
  final TextEditingController _welcomeTextController =
      TextEditingController(text: "Welcome to the Draft Page");

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
        title: Text('Draft'),
      ),
      body: Container(
          child: Column(
        children: [
          Row(
            //Will have to change the recentMails to recentDrafts
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
              Column(
                children: [
                  // RecentDrafts(),
                ],
              )
        ],
      )),
      bottomNavigationBar:
          BottomPanel(child: Container(), onTextUpdated: updateText),
    );
  }
}
