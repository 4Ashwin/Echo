import 'package:flutter/material.dart';

import '../../constants.dart';

class LoginButton extends StatelessWidget {
  // const LoginButton({ Key? key }) : super(key: key);

  // final Function() onPressed;
  final String text, image;
  Widget widget;
  LoginButton({
    required this.image,
    required this.text,
    required this.widget,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
                transitionDuration: Duration(milliseconds: 800),
                transitionsBuilder: (BuildContext context,
                    Animation<double> animation,
                    Animation<double> secondaryAnimation,
                    Widget child) {
                  return FadeTransition(
                    opacity: animation,
                    child: SlideTransition(
                      position: new Tween<Offset>(
                        begin: const Offset(0.0, 1.0),
                        end: Offset.zero,
                      ).animate(animation),
                      child: child,
                    ),
                  );
                }));
      },
      child: Container(
        constraints: BoxConstraints(maxWidth: 200.0, minHeight: 50.0),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Color(0xff84A5DC),
          borderRadius: BorderRadius.circular(80.0),
          boxShadow: [
            kLoginButtonBoxShadow,
          ],
        ),
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image(
              image: AssetImage(image),
            ),
            Text(
              text,
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
