import 'package:firebase_auth/firebase_auth.dart';

void getCurrentUserToken() {
  final FirebaseAuth auth = FirebaseAuth.instance;
  
  if (auth.currentUser != null) {
    auth.currentUser!.getIdToken().then((token) {
      print('ID Token: $token');
    }).catchError((error) {
      print('Error retrieving ID token: $error');
    });
  } else {
    print('User is not signed in.');
  }
}
