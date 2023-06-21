import 'package:echo/pages/compose/compose.dart';
import 'package:echo/pages/draft/draft.dart';
import 'package:echo/pages/read/read.dart';
import 'package:echo/widgets/bottommenu.dart';
import 'package:echo/widgets/buttons/homeButton.dart';
import 'package:echo/widgets/recentMails.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _userTextController = TextEditingController();
  FlutterTts _flutterTts = FlutterTts();
  final TextEditingController _welcomeTextController =
      TextEditingController(text: "Welcome to the Home Page. Say  echo compose to compose a mail, echo read to read a mail and echo draft to view your drafts. Say echo help for detailed instructions.");
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
        title: Text('Home'),
      ),
      body: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,

            // crossAxisAlignment: CrossAxisAlignment.,

            children: [
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                alignment: WrapAlignment.center,
                children: [
                  FractionallySizedBox(
                    widthFactor: 0.3,
                    child: HomeButton(
                      text: 'Compose',
                      image: 'images/email.png',
                      widget: ComposePage(),
                    ),
                  ),
                  FractionallySizedBox(
                    widthFactor: 0.3,
                    child: HomeButton(
                      text: 'Read',
                      image: 'images/read.png',
                      widget: ReadPage(),
                    ),
                  ),
                  FractionallySizedBox(
                    widthFactor: 0.3,
                    child: HomeButton(
                      text: 'Draft',
                      image: 'images/draft.png',
                      widget: DraftPage(),
                    ),
                  ),
                ],
              ),
              FutureBuilder<void>(
              future: Future.delayed(Duration(seconds: 2)), // Delay of 2 seconds
              builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // Show a loading indicator while waiting
                  return CircularProgressIndicator();
                } else {
                  // Render the RecentMails widget after the delay
                  return Expanded(
                    child: RecentMails(),
                  );
                }
              },
            ),
              //an elavated button to navigae to TestMail.dart
              // ElevatedButton(
              //     onPressed: () {
              //       Navigator.push(
              //         context,
              //         MaterialPageRoute(builder: (context) => TestMail()),
              //       );
              //     },
              //     child: Text('Test'),
              //   ),
            ],
          )),
      bottomNavigationBar:
          BottomPanel(child: Container(), onTextUpdated: updateText),
    );
  }
}
