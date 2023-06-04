import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../../Provider/google_sign_in.dart';
import '../home/home.dart';
import 'onboarding.dart';

class Profile extends StatefulWidget {
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FlutterTts flutterTts = FlutterTts();
  User? _user;
  String? _idToken;
  String? _accessToken;

  @override
  void initState() {
    super.initState();
    signInSuccess();
  }

  signInSuccess() async {
   speakText('Google sign in successful.');
    await Future.delayed(Duration(seconds: 2));
    final user = FirebaseAuth.instance.currentUser;
    speakText('Name: ${user?.displayName ?? 'Unknown'}');
    await Future.delayed(Duration(seconds: 2));
    speakText('Email: ${user?.email ?? 'Unknown'}');
    await Future.delayed(Duration(seconds: 3));
    speakText('Tap anywhere on the screen to continue. Tap on top right corner to logout');
    setState(() {
      _user = user;
    });

    // Get the Google authentication tokens
    final googleSignIn = GoogleSignIn();
    final googleUser = await googleSignIn.signIn();
    final googleAuth = await googleUser?.authentication;
    final idToken = googleAuth?.idToken;
    final accessToken = googleAuth?.accessToken;
    setState(() {
      _idToken = idToken;
      _accessToken = accessToken;
    });

    // Print the tokens in the console
    print('ID Token: $_idToken');
    print('Access Token: $_accessToken');
  }

  navigateToHome() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Home()),
    );
  }
speakText(String text) async {
    await flutterTts.setLanguage('en-US');
    await flutterTts.setPitch(1);
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.speak(text);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Logged In'),
        centerTitle: true,
        actions: [
          TextButton(
            child: Text('Logout', style: TextStyle(color: Colors.white)),
            onPressed: () {
              final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
              provider.logout();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => onboarding()),
              );
            },
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () {
          navigateToHome();
        },
        child: Container(
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
                backgroundImage: NetworkImage(_user?.photoURL ?? 'fallback_image_url'),
              ),
              SizedBox(height: 8),
              Text(
                'Name: ${_user?.displayName ?? 'Unknown'}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Email: ${_user?.email ?? 'Unknown'}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 32),
              Text(
                'Tap here to go to Home',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
