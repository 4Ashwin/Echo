import 'dart:developer';
// import 'dart:js_util';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:get/get.dart';
// import '../../core/api_provider_no_auth.dart';

class GoogleSignInProvider extends ChangeNotifier {
  var token;
  final googleSignIn = GoogleSignIn();

  // final ApiProviderNoAuth apiNoAuth = Get.find();

  GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;

  Future googleLogin(BuildContext context, Widget widget) async {
    try {
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) return;
      _user = googleUser;
      final googleAuth = await googleUser.authentication;
      print(googleAuth);
      print('haha');
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      token = googleAuth.accessToken;
      log('$token');
      // Map data = {'access_token': token};
      // final response = await apiNoAuth.postApi('/users/google', data);

      if (token != null) {
        HomeController hc = new HomeController();
        hc.postRequest(token);
      }

      final authResult =
          await FirebaseAuth.instance.signInWithCredential(credential);

      // Get the refresh token from the auth result
      final refreshToken = authResult.user!.refreshToken;
      print('credential:$credential     rToken: $refreshToken');

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
    } catch (e) {
      print(e.toString());
    }

    notifyListeners();
  }

  Future logout() async {
    try {
      await googleSignIn.disconnect();
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      print('Logout Error: ${e.toString()}');
    }
  }
}

class HomeController extends GetxController {
  Future<void> postRequest(token) async {
    // final token = Get.find<GoogleSignInProvider>().token;
    final response = await http.post(
      Uri.parse('https://echo-backend-production.up.railway.app/base/google'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'access_token': token,
      }),
    );
    if (response.statusCode == 200) {
      // The request was successful.
      log('200');
      print('Request successful!');
    } else {
      // The request failed.
      log('$response.statusCode');

      print('Request failed with status code ${response.statusCode}');
    }
  }
}



// import 'dart:developer';
// import 'package:alma/fcm/controller/fcm_controller.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import '../../core/api_provider.dart';
// import '../../core/api_provider_no_auth.dart';
// import '../models/user.dart';

// class AuthController extends GetxController {
//   late GoogleSignIn _googleSignIn;
//   final GetStorage _storage = GetStorage();
//   final ApiProvider api = Get.find();

//   final ApiProviderNoAuth apiNoAuth = Get.find();
//   final FcmController fcmController = Get.find();

//   var loginText = "Continue with Google".obs;
//   var isSigningIn = false.obs;

//   @override
//   void onInit() {
//     super.onInit();
//     _googleSignIn = GoogleSignIn();
//   }

//   void signout() async {
//     await _googleSignIn.signOut();
//     await _storage.erase();
//     Get.offAllNamed('/login');
//   }

//   Future<void> handleSignIn() async {
//     try {
//       loginText.value = "Logging you in ... ";
//       isSigningIn(true);
//       final result = await _googleSignIn.signIn();
//       final auth = await result!.authentication;

//       log("access token is ${auth.accessToken}");

//       Map data = {'access_token': auth.accessToken};
//       final response = await apiNoAuth.postApi('/users/google', data);

//       final apiToken = response.body['key'];

//       log('Api Token: $apiToken');

//       await _storage.write('authToken', apiToken);

//       final Response userResponse = await api.getApi('/users/current_user');
//       log('${userResponse.statusCode}');

//       log("${userResponse.body}");

//       final UserModel userModel = userModelFromJson(userResponse.body);

//       await _storage.write('user', userModel.toJson());
//       log('nameis${userModel.firstName}');

//       if (userModel.isVerified ?? false) {
//         await _storage.write('isVerified', true);
//       } else {
//         await _storage.write('isVerified', false);
//       }

//       //for fcm
//       await _storage.write('isDeviceAdded', false);
//       fcmController.fetchToken();
//       loginText.value = "Logged in ";
//       isSigningIn(false);

//       Get.offAllNamed('/');
//     } catch (error) {
//       isSigningIn(false);
//       loginText.value = "Try Again";
//       await Future.delayed(const Duration(seconds: 2));
//       loginText.value = "Continue with Google";
//       print(error);
//     } finally {
//       isSigningIn(false);
//       loginText.value = "Continue with Google";
//     }
//   }

//   //to logout
//   void logOut() async {
//     fcmController.removeDevice();
//   }
// }