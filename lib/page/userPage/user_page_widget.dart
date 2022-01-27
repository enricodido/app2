import 'package:checklist/components/flutter_flow_theme.dart';
import 'package:checklist/components/flutter_flow_widget.dart';
import 'package:checklist/model/selectModel.dart';
import 'package:checklist/model/user.dart';
import 'package:checklist/repositories/repository.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../main.dart';
import '../auth/login.dart';
import '../homePage/home.dart';

class UserPageWidgetArg {
  UserPageWidgetArg({
    required this.user,
  });

  final UserModel? user;
}

class UserPageWidget extends StatefulWidget {
  static const ROUTE_NAME = '/user';

  @override
  _UserPageWidgetState createState() => _UserPageWidgetState();
}

class _UserPageWidgetState extends State<UserPageWidget> {

  bool _loadingButton = false;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  UserModel? user;



  void logout(BuildContext context) {
    getIt.get<Repository>().sessionRepository!.logout();
    Navigator.pushNamedAndRemoveUntil(context, LoginPageWidget.ROUTE_NAME, ModalRoute.withName('/'));
  }

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance!.addPostFrameCallback((_) async {
      await getData();
    });
  }

  Future getData() async {

    setState(() { 

      final args = ModalRoute.of(context)!.settings.arguments as UserPageWidgetArg;
      user = args.user;


    });

    SharedPreferences preferences = await SharedPreferences.getInstance();  
    String val = preferences.getString('CHECKLIST_ID') ?? '0';

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.9,
              decoration: BoxDecoration(
                color: Color(0x00EEEEEE),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 60, 0, 20),
                    child: Icon(
                      Icons.account_circle,
                      color: Color(0xFF6E6767),
                      size: 65,
                    ),
                  ),
                  Text(
                    'Cognome',
                    style: FlutterFlowTheme.subtitle2.override(
                      fontFamily: 'Open Sans',
                      color: Colors.lightBlueAccent,
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: 45,
                      decoration: BoxDecoration(
                        color: Color(0x00EEEEEE),
                      ),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              user!.name,
                              style: FlutterFlowTheme.subtitle2.override(
                                fontFamily: 'Open Sans',
                                fontSize: 16,
                              ),
                            ),
                            Divider(
                              thickness: 1,
                              color: Colors.lightBlueAccent,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Text(
                    'Nome',
                    style: FlutterFlowTheme.subtitle2.override(
                      fontFamily: 'Open Sans',
                      color: Colors.lightBlueAccent,
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: 45,
                      decoration: BoxDecoration(
                        color: Color(0x00EEEEEE),
                      ),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              user!.lastname,
                              style: FlutterFlowTheme.subtitle2.override(
                                fontFamily: 'Open Sans',
                                fontSize: 16,
                              ),
                            ),
                            Divider(
                              thickness: 1,
                              color: Colors.lightBlueAccent,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Text(
                    'Email',
                    style: FlutterFlowTheme.subtitle2.override(
                      fontFamily: 'Open Sans',
                      color: Colors.lightBlueAccent,
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: 45,
                      decoration: BoxDecoration(
                        color: Color(0x00EEEEEE),
                      ),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              user!.email,
                              style: FlutterFlowTheme.subtitle2.override(
                                fontFamily: 'Open Sans',
                                fontSize: 16,
                              ),
                            ),
                            Divider(
                              thickness: 1,
                              color: Colors.lightBlueAccent,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: 70,
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        FFButtonWidget(
                          onPressed: () {
                            logout(context);
                          },
                          text: 'Logout',
                          options: FFButtonOptions(
                            width: double.infinity,
                            height: 50,
                            color: Colors.lightBlueAccent,
                            textStyle: FlutterFlowTheme.subtitle2.override(
                              fontFamily: 'Open Sans',
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                            borderSide: BorderSide(
                              color: Colors.transparent,
                              width: 1,
                            ),
                            borderRadius: 12,
                          ),
                          loading: _loadingButton,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.1,
              decoration: BoxDecoration(
                color: Color(0x00EEEEEE),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 12, 12, 12),
                    child: InkWell(
                      onTap: () async {
                        Navigator.pushNamed(context, HomePageWidget.ROUTE_NAME);
                      },
                      child: Image.asset(
                        'images/back-icona.png',
                        width: 100,
                        height: 100,
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
