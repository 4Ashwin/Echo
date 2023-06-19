import 'package:echo/pages/compose/compose.dart';
import 'package:echo/pages/draft/draft.dart';
import 'package:echo/pages/read/read.dart';
import 'package:echo/widgets/bottommenu.dart';
import 'package:echo/widgets/buttons/commonButton.dart';
import 'package:echo/widgets/buttons/homeButton.dart';
import 'package:echo/widgets/recentMails.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
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
      TextEditingController(text: "Welcome to the Home Page");
  void initState() {
    super.initState();

    _flutterTts.speak(_welcomeTextController.text);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

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
              Row(
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
              Expanded(
                child: RecentMails(),
              ),
            ],
          )),
      bottomNavigationBar:
          BottomPanel(child: Container(), onTextUpdated: updateText),
    );
  }
}
