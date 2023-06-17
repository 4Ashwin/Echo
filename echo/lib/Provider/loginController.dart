// import 'package:get/get.dart';
// // import 'package:google_sign_in/google_sign_in.dart';
// import 'google_sign_in.dart';
// class HomeController extends GetxController {
//   Future<void> postRequest() async {
//     final token = Get.find<GoogleSignInProvider>().token;
//     final response = await Get.post('1234sasfagh', {
//       'access_token': '$token',
//     });

//     if (response.statusCode == 200) {
//       // The request was successful.
//       print('Request successful!');
//     } else {
//       // The request failed.
//       print('Request failed with status code ${response.statusCode}');
//     }
//   }
// }