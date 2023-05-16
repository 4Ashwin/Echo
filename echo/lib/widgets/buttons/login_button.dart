import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Provider/google_sign_in.dart';
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
        final provider =
            Provider.of<GoogleSignInProvider>(context, listen: false);
        provider.googleLogin(context, widget);

        
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
