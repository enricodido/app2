import 'package:auto_size_text/auto_size_text.dart';
import 'package:checklist/blocs/user_me.dart';
import 'package:checklist/components/flutter_flow_theme.dart';
import 'package:checklist/components/flutter_flow_widget.dart';
import 'package:checklist/page/auth/login.dart';
import 'package:checklist/page/selectModel/selectModel.dart';
import 'package:checklist/page/userPage/user_page_widget.dart';
import 'package:checklist/repositories/repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import '../../main.dart';

class HomePageWidget extends StatefulWidget {
  static const ROUTE_NAME = '/home';

  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  Future refreshUserMe(BuildContext context) async {
    BlocProvider.of<UserMeBloc>(context).add(UserMeBlocRefreshEvent());
    BlocProvider.of<UserMeBloc>(context).add(UserMeBlocGetEvent());
  }

  void logout(BuildContext context) {
    getIt
        .get<Repository>()
        .sessionRepository!
        .logout();
    Navigator.pushNamedAndRemoveUntil(
        context, LoginPageWidget.ROUTE_NAME, ModalRoute.withName('/'));
  }

  @override
  Widget build(BuildContext context) {
    refreshUserMe(context);
    return Scaffold(
        key: scaffoldKey,
        backgroundColor: Color(0xFFF5F5F5),
        body:
        BlocBuilder<UserMeBloc, UserMeBlocState>(builder: (context, state) {
          if (state is UserMeBlocStateLoading)
            return Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: CircularProgressIndicator(
                      valueColor: new AlwaysStoppedAnimation<Color>(
                          Colors.lightBlueAccent),
                    ),
                  )
                ]);
          else {
            final user = (state as UserMeBlocStateLoaded).user;
            return Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 1,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        height: 90,
                        decoration: BoxDecoration(
                          color: Color(0xFF2CA4D4),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  10, 0, 0, 0),
                              child: Image.asset(
                                'images/logo-deltacall-check-esteso.png',
                                height: 80,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Expanded(
                              child: Align(
                                alignment: AlignmentDirectional(1, 0),
                                child: Padding(
                                  padding:
                                  EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 10, 0),
                                  child: InkWell(
                                    onTap: () async {
                                      await showDialog(
                                        context: context,
                                        builder: (alertDialogContext) {
                                          return AlertDialog(
                                            title: Text('Logout'),
                                            content: Text(
                                                'Vuoi effettuare il logOut?'),
                                            actions: [
                                              FFButtonWidget(
                                                onPressed: () {
                                                  logout(context);
                                                },
                                                text: 'Logout',
                                                options:
                                                FFButtonOptions(
                                                  width:
                                                  double.infinity,
                                                  height: 45,
                                                  color: Colors
                                                      .lightBlueAccent,
                                                  textStyle:
                                                  FlutterFlowTheme
                                                      .subtitle2
                                                      .override(
                                                    fontFamily:
                                                    'Poppins',
                                                    color: Colors.white,
                                                  ),
                                                  borderSide:
                                                  BorderSide(
                                                    color: Colors
                                                        .transparent,
                                                    width: 1,
                                                  ),
                                                  borderRadius: 12,
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    child: Text(
                                      'Logout',
                                      textAlign: TextAlign.center,
                                      style: FlutterFlowTheme.bodyText1
                                          .override(
                                        fontFamily: 'Open Sans',
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Color(0xFF6FBCDB),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding:
                    EdgeInsetsDirectional.fromSTEB(0, 10, 0, 30),
                    child: Text(
                      'Benvenuto' +
                          '\n ' +
                          user.name +
                          ' ' +
                          user.lastname,
                      textAlign: TextAlign.center,
                      style: FlutterFlowTheme.bodyText1.override(
                        fontFamily: 'Open Sans',
                        color: Color(0xFF2684AA),
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          GestureDetector(
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  7, 30, 7, 0),
                              child: FFButtonWidget(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context,
                                      SchedaControlliSceltaWidget.ROUTE_NAME,
                                      arguments: SchedaControlliSceltaWidgetArg(user: user));
                                },
                                text: 'Checklist Aperte',
                                options: FFButtonOptions(
                                  width: double.infinity,
                                  height: 90,
                                  color: Colors.white,
                                  textStyle: FlutterFlowTheme.subtitle2
                                      .override(
                                    fontFamily: 'Open Sans',
                                    color: Color(0xFF2CA4D4),
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  borderSide: BorderSide(
                                    color: Color(0xFF2CA4D4),
                                    width: 3,
                                  ),
                                  borderRadius: 15,
                                ),
                              ),
                            ),
                          ),

                        ]
                    ),
                  ),
                  Expanded(
                    child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          GestureDetector(
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  7, 30, 7, 0),
                              child: FFButtonWidget(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context,
                                      SchedaControlliSceltaWidget.ROUTE_NAME,
                                      arguments: SchedaControlliSceltaWidgetArg(user: user));
                                },
                                text: 'Nuova Checklist',
                                options: FFButtonOptions(
                                  width: double.infinity,
                                  height: 90,
                                  color: Colors.white,
                                  textStyle: FlutterFlowTheme.subtitle2
                                      .override(
                                    fontFamily: 'Open Sans',
                                    color: Color(0xFF2CA4D4),
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  borderSide: BorderSide(
                                    color: Color(0xFF2CA4D4),
                                    width: 3,
                                  ),
                                  borderRadius: 15,
                                ),
                              ),
                            ),
                          ),

                        ]
                    ),
                  ),
                  Expanded(
                    child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          GestureDetector(
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  7, 30, 7, 0),
                              child: FFButtonWidget(
                                onPressed: () {
                                 logout(context);
                                },
                                text: 'LOGOUT',
                                options: FFButtonOptions(
                                  width: double.infinity,
                                  height: 90,
                                  color: Colors.white,
                                  textStyle: FlutterFlowTheme.subtitle2
                                      .override(
                                    fontFamily: 'Open Sans',
                                    color: Color(0xFF2CA4D4),
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  borderSide: BorderSide(
                                    color: Color(0xFF2CA4D4),
                                    width: 3,
                                  ),
                                  borderRadius: 15,
                                ),
                              ),
                            ),
                          ),

                        ]
                    ),
                  ),
                 
                 /* GestureDetector(
                    child: Material(
                      color: Colors.transparent,
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width *
                            0.85,
                        height:
                        MediaQuery
                            .of(context)
                            .size
                            .height *
                            0.09,
                        decoration: BoxDecoration(
                          color: Color(0xFFEEEEEE),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 4,
                              color: Colors.lightBlueAccent,
                            )
                          ],
                          borderRadius: BorderRadius.circular(8),
                          shape: BoxShape.rectangle,
                        ),
                        child: FFButtonWidget(
                          onPressed: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    LoginPageWidget(),
                              ),
                            );
                          },
                          text: 'LOGOUT',
                          options: FFButtonOptions(
                            width: double.infinity,
                            height: 90,
                            color: Colors.white,
                            textStyle: FlutterFlowTheme.subtitle2
                                .override(
                              fontFamily: 'Open Sans',
                              color: Color(0xFF2CA4D4),
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                            borderSide: BorderSide(
                              color: Color(0xFF2CA4D4),
                              width: 3,
                            ),
                            borderRadius: 15,
                          ),
                        ),
                      ),
                    ),
                  )*/
                ],
              ),
            );
          }
        })
    );
  }
}