import 'package:flutter/material.dart';

import '../../constants.dart';
class SettingsButton extends StatelessWidget {
  final String text;
  final Widget widget;
  final VoidCallback onPressed;

  const SettingsButton({required this.text, required this.widget, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(text),
    );
  }
}
