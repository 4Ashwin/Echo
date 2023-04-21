
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';



class HomePageWidget extends StatefulWidget {
  const HomePageWidget({Key? key}) : super(key: key);

  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
  
  void dispose() {}
}

class _HomePageWidgetState extends State<HomePageWidget> {
  late HomePageWidget _model;      

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

 @override
void initState() {
  super.initState();
  _model = createModel(context, () => HomePageWidget());
}


  @override
  void dispose() {
    _model.dispose();

    _unfocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var elevatedButton = ElevatedButton(
                            onPressed: () {
                              print('Button pressed ...');
                            },
                            child: Container(
                              width: 110,
                              height: 130,
                              padding: EdgeInsets.zero,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: Color(0xFF84A5DC),
                                  width: 1,
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.grading),
                                  SizedBox(height: 8),
                                  Text(
                                    'Read',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
    var elevatedButton2 = ElevatedButton(
                      onPressed: () {
                        print('Button pressed ...');
                      },
                      child: Text(
                          'Draft',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.black, // Replace with your desired color
                            fontSize: 16, // Replace with your desired font size
                            fontWeight: FontWeight.w500, // Replace with your desired font weight
                          ),
                        ),

                      style: ElevatedButton.styleFrom(
                       primary: Theme.of(context).primaryColor,
                        onPrimary: Theme.of(context).primaryColorLight,

                        side: BorderSide(
                          color: Color(0xFF84A5DC),
                          width: 1,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        minimumSize: Size(110, 130),
                        padding: EdgeInsets.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                    );
     /* var slidableAction = SlidableAction(
                            label: 'Share',
                            backgroundColor: Theme.of(context).colorScheme.info,
                            icon: Icons.share,
                            onPressed: () {
                              print('SlidableActionWidget pressed ...');
                            },
                          ); 
             icon: Icons.share,
                                  onTap: () {
                                    print('SlidableActionWidget pressed ...');
                                  },
                                ); */
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Color(0xFFEAE7F0),
        body: SafeArea(
          child: Stack(
            children: [
              Align(
                alignment: AlignmentDirectional(0, -0.7),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
            ElevatedButton(
                        onPressed: () {
                          print('Button pressed ...');
                        },
                        child: Container(
                          width: 110,
                          height: 130,
                          padding: EdgeInsets.zero,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.edit,
                                color: Colors.black,
                                size: 24,
                              ),
                              Text(
                                'Compose',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.black, // Replace with your desired color
                                  fontSize: 16, // Replace with your desired font size
                                  fontWeight: FontWeight.w600, // Replace with your desired font weight
                                ),
                              ),

                            ],
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          onPrimary: Color(0xFF84A5DC),
                          side: BorderSide(
                            color: Color(0xFF84A5DC),
                            width: 1,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      )

                  ],
                ),
              ),
              Align(
                alignment: AlignmentDirectional(-0.6, -0.85),
                child: Text(
                  'Hi Username, Welcome Back!',
                  style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(-0.85, -0.31),
                child: Text(
                  'Recent Emails',
                  style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 20,
                      ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0.85, -0.31),
                child: Text(
                  'View All',
                  style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0, -0.9),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20, 335, 20, 150),
                  child: ListView(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                        child: Slidable(
                          endActionPane: ActionPane(
                            motion: const ScrollMotion(),
                            extentRatio: 0.25,
                            children: [


                            ],
                          ),
                          child: ListTile(
                            leading: Icon(
                              Icons.email_sharp,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                           title: Text(
                              'Subject',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                              ),
                            ),

                            subtitle: Text(
                                'Date',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey[600],
                                ),
                              ),

                           trailing: Icon(
                                Icons.arrow_forward_ios,
                                color: Theme.of(context).accentColor,
                                size: 20,
                              ),

                            tileColor: Colors.grey,
                            dense: false,
                            contentPadding:
                                EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                        child: Slidable(
                          endActionPane: ActionPane(
                            motion: const ScrollMotion(),
                            extentRatio: 0.25,
                            children: [
                             SlidableAction(
                                label: 'Share',
                                backgroundColor: Theme.of(context).accentColor,
                                icon: Icons.share,
                                onPressed: (_) {
                                  print('SlidableActionWidget pressed ...');
                                },
                              ),

                            ],
                          ),
                          child: ListTile(
                            leading: Icon(
                              Icons.email_sharp,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            title: Text(
                              'Subject',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                              ),
                            ),

                           subtitle: Text(
                              'Date',
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.normal,
                              ),
                            ),


                            trailing: Icon(
                              Icons.arrow_forward_ios,
                              color: Theme.of(context).accentColor,
                              size: 20,
                              ),
                            tileColor: Colors.grey,
                            dense: false,
                            contentPadding:
                                EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                        child: Slidable(
                          endActionPane: ActionPane(
                            motion: const ScrollMotion(),
                            extentRatio: 0.25,
                            children: [
                            /* SlidableAction(
                                        label: 'Share',
                                        backgroundColor: Theme.of(context).colorScheme.info,
                                        icon: Icons.share,
                                        onPressed: (_) {
                                          print('SlidableActionWidget pressed ...');
                                        },
                                      ), */


                            ],
                          ),
                      child: ListTile(
                          leading: Icon(
                            Icons.email_sharp,
                            color: Theme.of(context).primaryTextTheme.bodyText1?.color,
                          ),
                          title: Text(
                            'Subject',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              fontSize: 24,
                            ),
                          ),
                          subtitle: Text(
                            'Date',
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            color: Theme.of(context).accentColor,
                            size: 20,
                          ),
                          tileColor: Theme.of(context).colorScheme.secondary,
                          dense: false,
                          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),

                        ),
                      ),
                    ],
                  ),
                ),
              ),
            Align(
              alignment: AlignmentDirectional(0, 0.8),
              child: ElevatedButton.icon(
                onPressed: () {
                  print('Button pressed ...');
                },
                icon: Icon(
                  Icons.mic,
                  size: 45,
                ),
                label: Text(''),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(100, 100),
                  padding: EdgeInsets.zero,
                  primary: Color(0xFF84A5DC),
                  onPrimary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  side: BorderSide.none,
                ),
              ),
            ),

              Align(
                  alignment: AlignmentDirectional(-0.75, 0.75),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      print('Button pressed ...');
                    },
                    icon: Icon(
                      Icons.home,
                      size: 18,
                    ),
                    label: Text(''),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(50, 50),
                      padding: EdgeInsets.zero,
                      primary: Colors.grey, // Replace with the desired color
                      onPrimary: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                      side: BorderSide.none,
                    ),
                  ),
                ),

             Align(
                  alignment: AlignmentDirectional(0.75, 0.75),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      print('Button pressed ...');
                    },
                    icon: Icon(
                      Icons.settings,
                      size: 25,
                    ),
                    label: Text(''),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(50, 50),
                      padding: EdgeInsets.zero,
                      primary: Colors.grey, // Replace with the desired color
                      onPrimary: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                      side: BorderSide.none,
                    ),
                  ),
                ),

            ],
          ),
        ),
      ),
    );
  }
  
  T createModel<T>(BuildContext context, Widget Function() builder) {
  return Provider.of<T>(context, listen: false);
}

}
