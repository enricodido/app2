import 'package:auto_size_text/auto_size_text.dart';
import 'package:checklist/blocs/user_me.dart';
import 'package:checklist/components/flutter_flow_theme.dart';
import 'package:checklist/page/auth/login.dart';
import 'package:checklist/page/selectModel.dart';
import 'package:checklist/page/user_page_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

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
                  Container(
                    width: 75,
                    height: 75,
                    child: CircularProgressIndicator(
                      valueColor: new AlwaysStoppedAnimation<Color>(
                          Colors.lightBlueAccent),
                    ),
                  )
                ]);
          else {
            final user = (state as UserMeBlocStateLoaded).user;
            return Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.05,
                  decoration: BoxDecoration(
                    color: Colors.lightBlueAccent,
                  ),
                  child: Container(),
                ),
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.17,
                  decoration: BoxDecoration(
                    color: Color(0x00FFFFFF),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AutoSizeText(
                        user.name + ' ' + user.lastname,
                        maxLines: 1,
                        style: FlutterFlowTheme.bodyText1.override(
                          fontFamily: 'Poppins',
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                              context, UserPageWidget.ROUTE_NAME,
                              arguments: UserPageWidgetArg(user: user));
                        },
                        child: Icon(
                          Icons.account_circle_sharp,
                          color: Color(0xFF6E6767),
                          size: 65,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 30,
                  decoration: BoxDecoration(
                    color: Color(0x00EEEEEE),
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      GestureDetector(
                        child: Material(
                          color: Colors.transparent,
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.85,
                            height: MediaQuery.of(context).size.height * 0.09,
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
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(12, 4, 12, 4),
                                  child: Image.asset(
                                    'images/logo-deltacall-check.png',
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                AutoSizeText(
                                  'Checklist Aperte',
                                  maxLines: 1,
                                  style: FlutterFlowTheme.subtitle2.override(
                                    fontFamily: 'Open Sans',
                                    fontSize: 22,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        /*  onTap: () {
                              Navigator.pushNamed(
                                  context,
                                  SchedaControlliSceltaWidget.ROUTE_NAME,
                                  arguments: SchedaControlliSceltaWidgetArg(user: user)
                              );
                            },*/
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 15,
                        decoration: BoxDecoration(
                          color: Color(0x00EEEEEE),
                        ),
                      ),
                      GestureDetector(
                        child: Material(
                          color: Colors.transparent,
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.85,
                            height: MediaQuery.of(context).size.height * 0.09,
                            decoration: BoxDecoration(
                              color: Color(0xFFEEEEEE),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 4,
                                  color: Colors.lightBlueAccent
                                )
                              ],
                              borderRadius: BorderRadius.circular(8),
                              shape: BoxShape.rectangle,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(12, 4, 12, 4),
                                  child: Image.asset(
                                    'images/logo-deltacall-check.png',
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                AutoSizeText(
                                  'Nuova Checklist',
                                  maxLines: 1,
                                  style: FlutterFlowTheme.subtitle2.override(
                                    fontFamily: 'Open Sans',
                                    fontSize: 22,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        onTap: () {
                          Navigator.pushNamed(
                              context, SchedaControlliSceltaWidget.ROUTE_NAME,
                              arguments:
                                  SchedaControlliSceltaWidgetArg(user: user));
                        },
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 15,
                        decoration: BoxDecoration(
                          color: Color(0x00EEEEEE),
                        ),
                      ),
                      GestureDetector(
                          child: Material(
                            color: Colors.transparent,
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.85,
                              height: MediaQuery.of(context).size.height * 0.09,
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
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(12, 4, 12, 4),
                                    child: Image.asset(
                                      'images/logo-deltacall-check.png',
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                  AutoSizeText(
                                    'Logout',
                                    maxLines: 1,
                                    style: FlutterFlowTheme.subtitle2.override(
                                      fontFamily: 'Open Sans',
                                      fontSize: 22,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              LoginPageWidget.ROUTE_NAME,
                            );
                          })
                    ],
                  ),
                )
              ],
            );
          }
        })
    );
  }
}
