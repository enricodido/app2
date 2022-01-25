import 'package:checklist/components/flutter_flow_theme.dart';
import 'package:checklist/components/flutter_flow_widget.dart';
import 'package:checklist/model/selectModel.dart';
import 'package:checklist/model/user.dart';
import 'package:checklist/repositories/repository.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';
import 'auth/login.dart';
import 'home.dart';

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

  selectModel? model;
  List<selectModel> models = [];

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

      if(user!.model.status == 1) {
        user!.model.status.forEach((model) {
          models.add(model);
        });
      }

    });

    SharedPreferences preferences = await SharedPreferences.getInstance();  
    String val = preferences.getString('CHECKLIST_ID') ?? '0';

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xFFF5F5F5),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xFFEEEEEE),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: Image.asset(
              'images/pittogramma-logo-deltacall-check.png',
            ).image,
          ),
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
                    style: FlutterFlowTheme.bodyText1.override(
                      fontFamily: 'Poppins',
                      fontSize: 26,
                      fontWeight: FontWeight.w500,
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
                              style: FlutterFlowTheme.bodyText1.override(
                                fontFamily: 'Poppins',
                                fontSize: 16,
                              ),
                            ),
                            Divider(
                              thickness: 1,
                              color: Colors.black,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Text(
                    'Nome',
                    style: FlutterFlowTheme.bodyText1.override(
                      fontFamily: 'Poppins',
                      fontSize: 26,
                      fontWeight: FontWeight.w500,
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
                              style: FlutterFlowTheme.bodyText1.override(
                                fontFamily: 'Poppins',
                                fontSize: 16,
                              ),
                            ),
                            Divider(
                              thickness: 1,
                              color: Colors.black,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Text(
                    'Email',
                    style: FlutterFlowTheme.bodyText1.override(
                      fontFamily: 'Poppins',
                      fontSize: 26,
                      fontWeight: FontWeight.w500,
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
                              style: FlutterFlowTheme.bodyText1.override(
                                fontFamily: 'Poppins',
                                fontSize: 16,
                              ),
                            ),
                            Divider(
                              thickness: 1,
                              color: Colors.black,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Text(
                    'Punto  Vendita',
                    style: FlutterFlowTheme.bodyText1.override(
                      fontFamily: 'Poppins',
                      fontSize: 26,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: 70,
                      decoration: BoxDecoration(
                        color: Color(0x00EEEEEE),
                      ),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Align(
                              alignment: AlignmentDirectional(-0.05, 0.05),
                              child:  DropdownButton<selectModel>(
                                isExpanded: true,
                                value: model,
                                icon:
                                const Icon(Icons.arrow_drop_down),
                                iconSize: 24,
                                elevation: 16,
                                style: const TextStyle(
                                  color: Colors.deepPurple,
                                  fontSize: 20,
                                ),
                                underline: Container(
                                  height: 1,
                                  color: Colors.black,
                                ),
                                onChanged: (selectModel? value) async {
                                  SharedPreferences preferences = await SharedPreferences.getInstance();
                                  preferences.setString("SHOP_ID", value!.id);
                                  setState(() {
                                    model = value;
                                  });
                                },
                                items: models.map<DropdownMenuItem<selectModel>>((selectModel model) {
                                  return DropdownMenuItem<selectModel>(
                                    value: model,
                                    child: Text(model.description),
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: 45,
                    decoration: BoxDecoration(
                      color: Color(0xFFEEEEEE),
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
                            height: 45,
                            color: Color(0xFFFF0000),
                            textStyle: FlutterFlowTheme.subtitle2.override(
                              fontFamily: 'Poppins',
                              color: Colors.white,
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
                        'assets/images/indietro.png',
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
