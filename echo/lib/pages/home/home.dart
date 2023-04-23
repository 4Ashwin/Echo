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

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _userTextController = TextEditingController();

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
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  HomeButton(
                      text: 'Compose',
                      image: 'images/email.png',
                      widget: ComposePage()),
                  HomeButton(
                      text: 'Read',
                      image: 'images/read.png',
                      widget: ReadPage()),
                  HomeButton(
                      text: 'Draft',
                      image: 'images/draft.png',
                      widget: DraftPage()),
                ],
              ),
              SizedBox(
                height: 20,
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
              Column(
                children: [
                  RecentMails(),
                ],
              )
            ],
          )),
      bottomNavigationBar:
          BottomPanel(child: Container(), onTextUpdated: updateText),
    );
  }
}
