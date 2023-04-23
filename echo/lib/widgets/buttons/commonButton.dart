import 'package:flutter/material.dart';

import '../../constants.dart';

class CommonButton extends StatelessWidget {
  // const LoginButton({ Key? key }) : super(key: key);

  // final Function() onPressed;
  final String text;
  Widget widget;
  CommonButton({
    required this.text,
    required this.widget,
  });
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
                    return widget;
                  },
                  opaque: true,
                  barrierColor: Colors.grey,
                  transitionDuration: Duration(milliseconds: 600),
                  transitionsBuilder: (BuildContext context,
                      Animation<double> animation,
                      Animation<double> secondaryAnimation,
                      Widget child) {
                    return FadeTransition(
                      opacity: animation,
                      child: SlideTransition(
                        position: new Tween<Offset>(
                          begin: const Offset(2.0, 0.0),
                          end: Offset.zero,
                        ).animate(animation),
                        child: child,
                      ),
                    );
                  }));
        },
        child: Container(
          constraints: BoxConstraints(maxWidth: 200.0, minHeight: 70.0),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Color(0xff445696),
            borderRadius: BorderRadius.circular(80.0),
            boxShadow: [
              kLoginButtonBoxShadow,
            ],
          ),
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
