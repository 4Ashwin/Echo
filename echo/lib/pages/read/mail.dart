import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:echo/widgets/bottommenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class MailPage extends StatefulWidget {
  
   final String subject, date, sender,snippet;
  
 
  MailPage({
    
    required this.subject,
    required this.date,
    required this.sender,
    required this.snippet,
  });
   String getSubstring(txt) {
  if (txt.length >= 30) {
    return txt.substring(0,20);
  } else {
    return txt;
  }
}
String getSenderAddress(txt)
{
  txt=txt.split('<')[1];
  txt=txt.split('>')[0];
  return txt;
}
String getSenderName(txt)
{
  txt=txt.split('<')[0];
  // txt=txt.split('>')[0];
  return txt;
}

  @override
  State<MailPage> createState() => _MailPageState();
}

class _MailPageState extends State<MailPage> {

   
   

  
  final TextEditingController _userTextController = TextEditingController();

  FlutterTts _flutterTts = FlutterTts();
  final TextEditingController _welcomeTextController =
      TextEditingController(text: "You have opened an Email");

  void initState() {
    // super.initState();
    // _flutterTts.speak(_welcomeTextController.text);
    _readEmailContents();
  }

  Future<void> _readEmailContents() async {
    await _speakText(_welcomeTextController.text);

    
    await _speakText('Subject: ${widget.subject}');

    await _speakText('From: ${widget.sender}');

    // await _speakText('Email: ${widget.sender}');

    await _speakText(
        '${widget.snippet}');

    await _speakText('With regards,');

    await _speakText(widget.getSenderName(widget.sender));
  }

  Future<void> _speakText(String text) async {
    await _flutterTts.awaitSpeakCompletion(true);
    await _flutterTts.speak(text);
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
                      _flutterTts.speak("Going back to inbox page. ");
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
                      _flutterTts.speak("Do you wish to delete this email. ");
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Subject: ${widget.subject}',
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                    widget.getSenderName('${widget.sender}'),
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                    widget.getSenderAddress('${widget.sender}'),
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
              '${widget.snippet}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16),
            Text(
              'With regards,',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(
              widget.getSenderName(widget.sender),
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    // Handle reply button press
                    _flutterTts.speak(
                        "You have pressed reply button. Going to compose page. ");
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
                    _flutterTts.speak("You have pressed Forward button. ");
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
