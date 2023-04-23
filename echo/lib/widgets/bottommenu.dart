import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class BottomPanel extends StatefulWidget {
  final Widget child;

  BottomPanel({required this.child});

  @override
  _BottomPanelState createState() => _BottomPanelState();
}

class _BottomPanelState extends State<BottomPanel> {
  final stt.SpeechToText _speech = stt.SpeechToText();
  bool _isListening = false;
  String _text = '';

  void _startListening() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (status) {
          if (status == 'listening') {
            setState(() => _isListening = true);
          } else if (status == 'notListening') {
            setState(() => _isListening = false);
          }
        },
        onError: (error) {
          print('Error: $error');
        },
      );

      if (available) {
        _speech.listen(
          onResult: (result) {
            setState(() => _text = result.recognizedWords);
            print(result.recognizedWords);
          },
        );
      }
    }
  }

  void _stopListening() {
    if (_isListening) {
      _speech.stop();
      setState(() => _isListening = false);
    }
  }

  @override
  void initState() {
    super.initState();
    _speech.initialize();
  }

  @override
  void dispose() {
    super.dispose();
    _speech.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // main content of the screen
        Positioned(
          top: 0,
          bottom: 50,
          left: 0,
          right: 0,
          child: widget.child,
        ),

        // panel at the bottom
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 120,
            color: Colors.grey[300],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Image.asset('assets/images/homesymbol.png'),
                  iconSize: 30,
                  onPressed: () {},
                ),
                IconButton(
                  icon: _isListening
                      ? Image.asset('assets/images/mic1_active.png')
                      : Image.asset('assets/images/mic1.png'),
                  iconSize: 100,
                  onPressed: _isListening ? _stopListening : _startListening,
                ),
                IconButton(
                  icon: Image.asset('assets/images/settingsymbol.png'),
                  iconSize: 30,
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),

        // display text
        Positioned(
          top: 50,
          bottom: 200,
          left: 0,
          right: 0,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              _text,
              style: TextStyle(fontSize: 14),
            ),
          ),
        ),
      ],
    );
  }
}
