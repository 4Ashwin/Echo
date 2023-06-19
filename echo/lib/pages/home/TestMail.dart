import 'package:echo/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class TestMail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get the EmailProvider instance
    List<String> D2 =
        Constants.Data_to_send.where((element) => element.isNotEmpty).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Test Mail'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            child: Text('Send Mail'),
            onPressed: () => sendEmail(),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: D2.length,
              itemBuilder: (BuildContext context, int index) {
                String data = D2[index];
                return ListTile(
                  title: Text(data),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future sendEmail() async {
    final email = Constants.theuser;
    final token = Constants.accesstoken;

    print('Email: $email');

    final smtpServer = gmailSaslXoauth2(email, token);
    final message = Message()
      ..from = Address(email, Constants.nameuser)
      // ..recipients = [Constants.Data_to_send[0]]
      ..recipients = ['echo.voice.email@gmail.com']
      // ..subject = Constants.Data_to_send[1]
       ..subject = 'test subject from echo'
//       ..text = '''
// ${Constants.Data_to_send[3]},

// ${Constants.Data_to_send[4]}

// ${Constants.Data_to_send[5]},
// ${Constants.nameuser}
// ''';

 ..text = '''
Hi ashwin
Hope you are well
Deepak says Hi !
${Constants.nameuser}
''';

    try {
      await send(message, smtpServer);
      print('Message sent');
    } on MailerException catch (e) {
      print('Message not sent. $e');
    } catch (e) {
      print('Unknown error. $e');
    }
  }
}
