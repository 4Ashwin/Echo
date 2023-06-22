import 'package:echo/pages/compose/compose.dart';
import 'package:echo/pages/home/home.dart';
import 'package:echo/pages/settings/settings.dart';
import 'package:echo/widgets/buttons/customiconbtn.dart';
import 'package:echo/widgets/buttons/recorderButton.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class BottomPanel extends StatefulWidget {
  final Widget child;
  final void Function(String) onTextUpdated;

  // BottomPanel({required this.child});
  const BottomPanel({required this.child, required this.onTextUpdated});

  @override
  _BottomPanelState createState() => _BottomPanelState();
}

class _BottomPanelState extends State<BottomPanel> {
  final stt.SpeechToText _speech = stt.SpeechToText();
  bool _isListening = false;
  final TextEditingController _userTextController = TextEditingController();

  void updateText(String text) {
    setState(() {
      _userTextController.text = text;
    });
    widget.onTextUpdated(text);
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      padding: EdgeInsets.only(bottom: 10),
      child: Container(
        height: 160,
        alignment: Alignment.bottomCenter,
        child: Column(
          children: [
            TextField(
              controller: _userTextController,
              enabled: false,
              maxLines: null,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      width: 3, color: Colors.greenAccent), //<-- SEE HERE
                ),
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomIconButton(
                    image: 'assets/images/homesymbol.png', widget: Home()),
                RecorderButton(onTextUpdated: updateText),
                CustomIconButton(
                    image: 'assets/images/settingsymbol.png',
                    widget: Settings()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
