import 'dart:convert';
import 'dart:developer';

import 'package:echo/pages/read/read.dart';
import 'package:echo/widgets/buttons/mailButton.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../pages/read/mail.dart';

class RecentMails extends StatefulWidget {
  @override
  _RecentMailsState createState() => _RecentMailsState();
}

class _RecentMailsState extends State<RecentMails> {
  // Future<http.Response> fetchMails() {
  //   return http.get(Uri.parse(
  //       'https://echo-backend-production.up.railway.app/base/emails'));
  // }

  Future<List<dynamic>> fetchMails() async {
    final response = await http.get(Uri.parse(
        'https://echo-backend-production.up.railway.app/base/emails'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      final parsedData = json.decode(response.body);
      log("${parsedData}");
      return parsedData;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load ');
    }
  }

  late Future<List<dynamic>> mails;
  @override
  void initState() {
    super.initState();
    fetchMails().then((value) {
      setState(() {
        mails = Future.value(value);
        print('mails = $value');
      });
    }).catchError((error) {
      print('Error: $error');
    });
  }

  // https://echo-backend-production.up.railway.app/base/emails/
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
            text: 'IEDC',
            date: '23-04-2023',
            sender: 'iedc@gmail.com',
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
