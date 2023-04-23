import 'package:echo/pages/read/read.dart';
import 'package:echo/widgets/buttons/mailButton.dart';
import 'package:flutter/material.dart';

class RecentMails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Column(
        children: [
          MailButton(
            text: 'New Admission',
            date: '23-04-2023',
            sender: 'abc@gmail.com',
            widget: ReadPage(),
          ),
          MailButton(
            text: 'New Admission',
            date: '23-04-2023',
            sender: 'abc@gmail.com',
            widget: ReadPage(),
          ),
          MailButton(
            text: 'New Admission',
            date: '23-04-2023',
            sender: 'abc@gmail.com',
            widget: ReadPage(),
          ),
          MailButton(
            text: 'New Admission',
            date: '23-04-2023',
            sender: 'abc@gmail.com',
            widget: ReadPage(),
          ),
          MailButton(
            text: 'New Admission',
            date: '23-04-2023',
            sender: 'abc@gmail.com',
            widget: ReadPage(),
          ),
        ],
      ),
    );
  }
}

Widget _myListView(BuildContext context) {
  // backing data
  final europeanCountries = [
    'Albania',
    'Andorra',
    'Armenia',
    'Austria',
    'Azerbaijan',
    'Belarus',
    'Belgium',
    'Bosnia and Herzegovina',
    'Bulgaria',
    'Croatia',
    'Cyprus'
  ];
  return ListView.builder(
    itemCount: europeanCountries.length,
    itemBuilder: (context, index) {
      return ListTile(
        title: Text(europeanCountries[index]),
      );
    },
  );
}
