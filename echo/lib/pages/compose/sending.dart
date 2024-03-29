import 'package:echo/constants/constants.dart';
import 'package:echo/widgets/bottommenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../../models/draft_model.dart';

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
      _flutterTts.speak(
          'Do you wish to send this email? Say confirm to send or discard to discard.');
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Mail'),
      ),
      body: GestureDetector(
        onTap: readEmailContent,
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Text(
                '${Constants.Data_to_send[1]}',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  CircleAvatar(
                    // backgroundImage: AssetImage('profile_image.png'),
                    radius: 24,
                  ),
                  SizedBox(width: 8),
                  Flexible(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Text(
                              '${Constants.Data_to_send[0]}',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Text(
                            '${Constants.Data_to_send[1]}',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 16),
              Text(
                '${Constants.Data_to_send[3]}',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 16),
              Text(
                '${Constants.Data_to_send[4]}',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 16),
              Text(
                '${Constants.Data_to_send[5]}',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 8),
              Text(
                '${Constants.nameuser}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      _flutterTts.speak("You have pressed Confirm button.");
                    },
                    icon: Icon(Icons.reply),
                    label: Text('Confirm'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      _flutterTts.speak("You have pressed Discard button.");
                      addDraft();
                    },
                    icon: Icon(Icons.forward),
                    label: Text('Discard'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar:
          BottomPanel(child: Container(), onTextUpdated: updateText),
    );
  }

  void addDraft() {
    // Create a new DraftModel instance using the provided content
    DraftModel draft = DraftModel(
      subject: Constants.Data_to_send[1],
      sender: Constants.nameuser,
      receiver: Constants.Data_to_send[0],
      date: '23-06-23',
      snippet: Constants.Data_to_send[4],
      readStatus: true,
    );

    // print(
    // 'subj:${Constants.Data_to_send[1]}\nsender:${Constants.nameuser}\nrec:${Constants.Data_to_send[0]}   date:${11 / 12 / 2023 ');

    // Add the new draft to the draftMessages list

    Constants.draftMessages.add(draft);
  }
}
