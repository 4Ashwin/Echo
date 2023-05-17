import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:echo/widgets/bottommenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class MailPage extends StatefulWidget {
  @override
  State<MailPage> createState() => _MailPageState();
}

class _MailPageState extends State<MailPage> {
  final TextEditingController _userTextController = TextEditingController();

  FlutterTts _flutterTts = FlutterTts();
  final TextEditingController _welcomeTextController =
      TextEditingController(text: "You have opened an Email");

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
        title: Text('Mail'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    icon: Icon(
                      Icons.mail,
                      color: Colors.black,
                      size: 40,
                    ),
                    onPressed: () {
                      // Handle mail icon onPressed event
                    },
                  ),
                ),
                Spacer(),
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red,
                      size: 40,
                    ),
                    onPressed: () {
                      // Handle delete icon onPressed event
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Subject: Hello',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage('profile_image.png'),
                  radius: 24,
                ),
                SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'John Doe',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'john@example.com',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16),
            Text(
              'Yes, I totally agree with you. Let me take two days to finish it. And then you can check it out.',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16),
            Text(
              'Best regards,',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(
              'John',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
              onPressed: () {
                // Handle reply button press
              },
              icon: Icon(Icons.reply),
              label: Text('Reply'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              ),
            ),
            ElevatedButton.icon(
              onPressed: () {
                // Handle forward button press
              },
              icon: Icon(Icons.forward),
              label: Text('Forward'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              ),
            ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar:
          BottomPanel(child: Container(), onTextUpdated: updateText),
    );
  }
}
