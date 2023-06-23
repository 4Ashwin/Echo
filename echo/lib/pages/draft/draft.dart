import 'package:echo/widgets/recentDrafts.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:echo/widgets/bottommenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../../constants.dart';
import '../../constants/constants.dart';
import '../../models/draft_model.dart';
import '../../widgets/recentMails.dart';
import 'draftview.dart';

class DraftPage extends StatefulWidget {
  const DraftPage({super.key});

  @override
  State<DraftPage> createState() => _DraftPageState();
}

class _DraftPageState extends State<DraftPage> {
  final TextEditingController _userTextController = TextEditingController();

  FlutterTts _flutterTts = FlutterTts();
  final TextEditingController _welcomeTextController =
      TextEditingController(text: "Welcome to the Drafts Page");

  void initState() {
    super.initState();

    _flutterTts.speak(_welcomeTextController.text);
  }
// List<DraftModel> draftMessages = [
//   DraftModel(
//     subject: 'Sample Subject 1',
//     sender: 'John Doe',
//     receiver: 'Jane Smith',
//     date: '2023-06-21',
//     snippet: 'This is a sample draft message.',
//     readStatus: false,
//     annotations: Annotations(),
//   ),
//   DraftModel(
//     subject: 'Sample Subject 2',
//     sender: 'Alice Johnson',
//     receiver: 'Bob Smith',
//     date: '2023-06-22',
//     snippet: 'This is another sample draft message.',
//     readStatus: true,
//     annotations: Annotations(),
//   ),
  // Add more draft messages as needed
// ];

  @override
  Widget build(BuildContext context) {
    void updateText(String text) {
      setState(() {
        _userTextController.text = text;
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Draft'),
      ),
      body: Container(
          child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: Constants.draftMessages.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.all(10),

                  child: GestureDetector(
                    onTap: () {
                      // handleSelect(index);

                      Navigator.push(
                          context,
                          PageRouteBuilder(
                              pageBuilder: (BuildContext context,
                                  Animation animation,
                                  Animation secondaryAnimation) {
                                return DraftViewPage(
                                    sender: Constants
                                        .draftMessages[index].sender
                                        .toString(),
                                    subject: Constants
                                        .draftMessages[index].subject
                                        .toString(),
                                    snippet: Constants
                                        .draftMessages[index].snippet
                                        .toString(),
                                    date: Constants.draftMessages[index].date
                                        .toString());
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
                      constraints:
                          BoxConstraints(maxWidth: 400.0, minHeight: 50.0),
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
                                // getSubstring('${emails[index].subject.toString()}')
                                Constants.draftMessages[index].subject
                                    .toString(),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                                overflow: TextOverflow.ellipsis,
                              ),
                              Column(
                                children: [
                                  Text(
                                    Constants.draftMessages[index].date
                                        .toString(),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 10,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Text(
                                    Constants.draftMessages[index].receiver
                                        .toString(),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 10,
                                      overflow: TextOverflow.ellipsis,
                                    ),
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
                );
              },
            ),
          )
        ],
      )),
      bottomNavigationBar:
          BottomPanel(child: Container(), onTextUpdated: updateText),
    );
  }
}
