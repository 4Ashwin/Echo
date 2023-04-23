import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final String image;
  Widget widget;
  CustomIconButton({required this.image, required this.widget});
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Image.asset(image),
      iconSize: 30,
      onPressed: () {
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
                        begin: const Offset(1.0, 0.0),
                        end: Offset.zero,
                      ).animate(animation),
                      child: child,
                    ),
                  );
                }));
      },
    );
  }
}
