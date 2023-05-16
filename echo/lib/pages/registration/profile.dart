import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Provider/google_sign_in.dart';
import '../home/home.dart';
import 'onboarding.dart';

class Profile extends StatefulWidget {
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

@override
  void initState (){
    navigatetohome();
    super.initState();
  }

navigatetohome() async {
  await Future.delayed(Duration(seconds: 8));
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Home()),
    );
}

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text('Logged In'),
        centerTitle: true,
        actions: [
          TextButton(
              child: Text('Logout', style: TextStyle(color: Colors.white)),
              onPressed: () {
                final provider =
                    Provider.of<GoogleSignInProvider>(context, listen: false);
                provider.logout();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => onboarding()),
                );
              })
            
        ],
      ),
      body: Container(
        alignment: Alignment.center,
        color: Colors.blueGrey.shade900,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Profile',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 32),
            CircleAvatar(
              radius: 40,
              backgroundImage:
                  NetworkImage(user?.photoURL ?? 'fallback_image_url'),
            ),
            SizedBox(height: 8),
            Text(
              'Name: ' + (user?.displayName ?? 'Unknown'),
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Email: ' + (user?.email ?? 'Unknown'),
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
