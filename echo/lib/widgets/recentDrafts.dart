import 'package:echo/pages/compose/compose.dart';
import 'package:echo/pages/read/read.dart';
import 'package:echo/widgets/buttons/mailButton.dart';
import 'package:flutter/material.dart';

import '../pages/read/mail.dart';

class RecentDrafts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Column(
        children: [
          MailButton(
            text: 'New Admission',
            date: '23-04-2023',
            sender: 'abc@gmail.com',
            widget: ComposePage(),
          ),
          MailButton(
            text: 'New Admission',
            date: '23-04-2023',
            sender: 'abc@gmail.com',
            widget: ComposePage(),
          ),
          MailButton(
            text: 'New Admission',
            date: '23-04-2023',
            sender: 'abc@gmail.com',
            widget: ComposePage(),
          ),
          MailButton(
            text: 'New Admission',
            date: '23-04-2023',
            sender: 'abc@gmail.com',
            widget: ComposePage(),
          ),
          MailButton(
            text: 'New Admission',
            date: '23-04-2023',
            sender: 'abc@gmail.com',
            widget: ComposePage(),
          ),
        ],
      ),
    );
  }
}
