import 'package:echo/pages/registration/onboarding.dart';
import 'package:echo/pages/registration/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class LoggedIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
    body: StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return Center(child: CircularProgressIndicator());
        else if (snapshot.hasData) {
          return Profile();
        } else if (snapshot.hasError) {
          return Center(child: Text('Something Went Wrong!'));
        } else
        return onboarding();
      }
    ),
  );
}