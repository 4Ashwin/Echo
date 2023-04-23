import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:echo/widgets/bottommenu.dart';
import 'package:flutter/material.dart';

class ReadPage extends StatefulWidget {
  const ReadPage({super.key});

  @override
  State<ReadPage> createState() => _ReadPageState();
}

class _ReadPageState extends State<ReadPage> {
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
        title: Text('Inbox'),
      ),
      body: Container(
          child: Column(
        children: [
          Text('Welcome to Inbox Page')
          // ElevatedButton(
          //   child: const Text('Compose'),
          //   onPressed: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(builder: (context) => ComposePage()),
          //     );
          //     // Navigate to second route when tapped.
          //   },
          // ),
          // ElevatedButton(
          //   child: const Text('Read'),
          //   onPressed: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(builder: (context) => ComposePage()),
          //     );
          //     // Navigate to second route when tapped.
          //   },
          // ),
        ],
      )),
      bottomNavigationBar:
          BottomPanel(child: Container(), onTextUpdated: updateText),
    );
  }
}
