import 'package:echo/pages/home/home.dart';
import 'package:echo/pages/read/mail.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

class MailButton extends StatelessWidget {
  // const LoginButton({ Key? key }) : super(key: key);

  // final Function() onPressed;
  final String text, date, sender;
  final List data;
  // Widget widget;
  MailButton({
    required this.text,
    required this.date,
    required this.sender,
    required this.data,
  });


String getDate(txt)
{
  txt=txt.split(',')[1];
  txt=txt.split('+')[0];
  return txt;
}
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              PageRouteBuilder(
                  pageBuilder: (BuildContext context, Animation animation,
                      Animation secondaryAnimation) {
                    return Home();
                  },
                  opaque: true,
                  barrierColor: Colors.grey,
                  transitionDuration: Duration(milliseconds: 500),
                  transitionsBuilder: (BuildContext context,
                      Animation<double> animation,
                      Animation<double> secondaryAnimation,
                      Widget child) {
                    return FadeTransition(
                      opacity: animation,
                      child: SlideTransition(
                        position: new Tween<Offset>(
                          begin: const Offset(1.0, 0.0),
                          end: Offset.zero,
                        ).animate(animation),
                        child: child,
                      ),
                    );
                  }));
        },
        child: Container(
          constraints: BoxConstraints(maxWidth: 400.0, minHeight: 50.0),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              kLoginButtonBoxShadow,
            ],
          ),
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image(
                image: AssetImage('images/read2.png'),
              ),
              SizedBox(
                width: 50,
              ),
              Column(
                children: [
                  Text(
                    'subj',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                  ),
                  Column(
                    children: [
                      Text(
                        'date',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                            fontSize: 10,
                            overflow: TextOverflow.ellipsis,),
                      ),
                      Text(
                        'sender',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                            fontSize: 10,
                            overflow: TextOverflow.ellipsis,),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
