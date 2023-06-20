import 'dart:convert';
import 'dart:developer';

import 'package:echo/pages/read/read.dart';
import 'package:echo/widgets/buttons/mailButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:http/http.dart' as http;
import '../constants.dart';
import '../models/mail_model.dart';
import '../pages/read/mail.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class RecentMails extends StatefulWidget {
  @override
  _RecentMailsState createState() => _RecentMailsState();
}

class _RecentMailsState extends State<RecentMails> {
  var unreadCount;

  // Future<http.Response> fetchMails() {
  //   return http.get(Uri.parse(
  //       'https://echo-backend-production.up.railway.app/base/emails'));
  // }
  String getSubstring(txt) {

  if (txt.length >= 30) {
    return txt.substring(0,20);
  } else {
    return txt;
  }
}
String getSender(txt)
{
  txt=txt.split('<')[1];
  txt=txt.split('>')[0];
  return txt;
}
String getDate(txt)
{
  txt=txt.split(',')[1];
  txt=txt.split('+')[0];
  return txt;
}
   List<Mail> emails=[];
  Future<List<dynamic>> fetchMails() async {
    final response = await http.get(Uri.parse(  
        'https://echo-backend-production.up.railway.app/base/emails'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      List<Mail> parsedData =mailFromJson(response.body);
      setState(() {
        isLoading=false;
      });
      emails.forEach((mail) {
        if(mail.readStatus==null || mail.readStatus!=true)
  mail.readStatus = false;
});
      
      print(parsedData[0].sender);
      emails=parsedData;
      unreadCount=emails.length;
      _welcomeTextController =
        TextEditingController(text: "You have $unreadCount unread emails.");
    _flutterTts.speak(_welcomeTextController.text);
      return parsedData;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load ');
    }
  }

  //  final TextEditingController _welcomeTextController =
  //     TextEditingController(text: "You have $unreadCount unread emails.");
    FlutterTts _flutterTts = FlutterTts();
        late TextEditingController _welcomeTextController;
  
  late bool isLoading;
  late Future<List<dynamic>> mails;
  @override
  void initState() {
    super.initState();
    isLoading = true;
    mails = fetchMails();
    
    
    
    //  isLoading=false;
    
  }


  // https://echo-backend-production.up.railway.app/base/emails/
  @override
  Widget build(BuildContext context) {
    // return ListTile(
    //   leading: Text("hello"),
    // );
    return Center(
        child: isLoading
            ? SpinKitFadingCircle(color: Colors.blue,size: 30,duration: Duration(milliseconds: 3000),)
            :ListView.builder(shrinkWrap:true,itemCount:emails.length,itemBuilder: (context,index){
      return Padding(
        padding: EdgeInsets.all(10),
        
      child: GestureDetector(
        onTap: () {
          handleSelect(index);
          
          
          Navigator.push(
              context,
              PageRouteBuilder(
                  pageBuilder: (BuildContext context, Animation animation,
                      Animation secondaryAnimation) {
                    return MailPage(sender:emails[index].sender.toString(),subject:emails[index].subject.toString(),snippet:emails[index].snippet.toString(),date:emails[index].date.toString());
                  },
                  opaque: true,
                  barrierColor: Colors.grey,
                  transitionDuration: Duration(milliseconds: 500),
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
        child: Container(
          constraints: BoxConstraints(maxWidth: 400.0, minHeight: 50.0),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              kLoginButtonBoxShadow,
            ],
          ),
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image(
                image: AssetImage('images/read2.png'),
              ),
              SizedBox(
                width: 50,
              ),
              Column(
                children: [
                  Text(
                    getSubstring('${emails[index].subject.toString()}'),
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                  ),
                  Column(
                    children: [
                      Text(
                        getDate('${emails[index].date.toString()}'),
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                            fontSize: 10,
                            overflow: TextOverflow.ellipsis,),
                      ),
                      Text(
                        getSender('${emails[index].sender.toString()}'),
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                            fontSize: 10,
                            overflow: TextOverflow.ellipsis,),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    
        
        // Container(height: 50,
        // width: 100,
        // child: Text(emails[index].sender.toString()),
        // color: Colors.red,),
      )
      ;
    }),);
  }
  
  void handleSelect(int index) {
    if(emails[index].readStatus==false){
        setState(() {
      emails[index].readStatus=true;
      unreadCount--;
    },);
    }
    
  }
}
