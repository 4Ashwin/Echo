import 'package:echo/pages/read/read.dart';
import 'package:echo/widgets/buttons/mailButton.dart';
import 'package:flutter/material.dart';

import '../pages/read/mail.dart';

class RecentMails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Column(
        children: [
          MailButton(
            text: 'New Admission',
            date: '23-04-2023',
            sender: 'tkmce@gmail.com',
            widget: MailPage(),
          ),
          MailButton(
            text: 'Internship Offer',
            date: '23-04-2023',
            sender: 'fevr@gmail.com',
            widget: MailPage(),
          ),
          MailButton(
            text: 'Overleaf',
            date: '23-04-2023',
            sender: 'overleaf@gmail.com',
            widget: MailPage(),
          ),
          MailButton(
            text: 'IEDC Certificate',
            date: '23-04-2023',
            sender: 'iedctkmce@gmail.com',
            widget: MailPage(),
          ),
          MailButton(
            text: 'New Admission',
            date: '23-04-2023',
            sender: 'abc@gmail.com',
            widget: MailPage(),
          ),
        ],
      ),
    );
  }
}
