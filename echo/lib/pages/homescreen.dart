
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';



class HomePageWidget extends StatefulWidget {
  const HomePageWidget({Key? key}) : super(key: key);

  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  late HomePageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomePageModel());
  }

  @override
  void dispose() {
    _model.dispose();

    _unfocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                    FFButtonWidget(
                      onPressed: () {
                        print('Button pressed ...');
                      },
                      text: 'Compose',
                      options: FFButtonOptions(
                        width: 110,
                        height: 130,
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                        iconPadding:
                            EdgeInsetsDirectional.fromSTEB(0, 0, 60, 60),
                        color: Colors.white,
                        textStyle: FlutterFlowTheme.of(context)
                            .titleSmall
                            .override(
                              fontFamily: 'Poppins',
                              color: FlutterFlowTheme.of(context).primaryText,
                            ),
                        borderSide: BorderSide(
                          color: Color(0xFF84A5DC),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    FFButtonWidget(
                      onPressed: () {
                        print('Button pressed ...');
                      },
                      text: 'Read',
                      options: FFButtonOptions(
                        width: 110,
                        height: 130,
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                        iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                        color: Colors.white,
                        textStyle: FlutterFlowTheme.of(context)
                            .titleSmall
                            .override(
                              fontFamily: 'Poppins',
                              color: FlutterFlowTheme.of(context).primaryText,
                            ),
                        borderSide: BorderSide(
                          color: Color(0xFF84A5DC),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    FFButtonWidget(
                      onPressed: () {
                        print('Button pressed ...');
                      },
                      text: 'Draft',
                      options: FFButtonOptions(
                        width: 110,
                        height: 130,
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                        iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                        color: FlutterFlowTheme.of(context).primaryBackground,
                        textStyle: FlutterFlowTheme.of(context)
                            .titleSmall
                            .override(
                              fontFamily: 'Poppins',
                              color: FlutterFlowTheme.of(context).primaryText,
                            ),
                        borderSide: BorderSide(
                          color: Color(0xFF84A5DC),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
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
                              SlidableAction(
                                label: 'Share',
                                backgroundColor:
                                    FlutterFlowTheme.of(context).info,
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
                              color: FlutterFlowTheme.of(context).primaryText,
                            ),
                            title: Text(
                              'Subject',
                              style: FlutterFlowTheme.of(context)
                                  .titleMedium
                                  .override(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                            subtitle: Text(
                              'Date',
                              style: FlutterFlowTheme.of(context).labelMedium,
                            ),
                            trailing: Icon(
                              Icons.arrow_forward_ios,
                              color: FlutterFlowTheme.of(context).accent2,
                              size: 20,
                            ),
                            tileColor: FlutterFlowTheme.of(context)
                                .secondaryBackground,
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
                                backgroundColor:
                                    FlutterFlowTheme.of(context).info,
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
                              color: FlutterFlowTheme.of(context).primaryText,
                            ),
                            title: Text(
                              'Subject',
                              style: FlutterFlowTheme.of(context)
                                  .titleMedium
                                  .override(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                            subtitle: Text(
                              'Date',
                              style: FlutterFlowTheme.of(context).labelMedium,
                            ),
                            trailing: Icon(
                              Icons.arrow_forward_ios,
                              color: FlutterFlowTheme.of(context).accent2,
                              size: 20,
                            ),
                            tileColor: FlutterFlowTheme.of(context)
                                .secondaryBackground,
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
                                onTap: () {
                                  print('SlidableActionWidget pressed ...');
                                },
                              ),


                            ],
                          ),
                          child: ListTile(
                            leading: Icon(
                              Icons.email_sharp,
                              color: FlutterFlowTheme.of(context).primaryText,
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

                            tileColor: Theme.of(context)
                                .secondaryBackground,
                            dense: false,
                            contentPadding:
                                EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
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
}
