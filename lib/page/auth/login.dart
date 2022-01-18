import 'package:checklist/components/customButtonPrimary.dart';
import 'package:checklist/components/customDialog.dart';
import 'package:checklist/components/flutter_flow_theme.dart';
import 'package:checklist/components/flutter_flow_widget.dart';
import 'package:checklist/repositories/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import '../../main.dart';
import '../home.dart';
import '../selectModel.dart';


class LoginPage extends StatefulWidget {
  static const ROUTE_NAME = '/login';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool visible = false;

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String usernameError = 'username richiesta.';
  String passwordError = 'Password richiesta.';
  final _formKey = GlobalKey<FormState>();

  void onSubmit() async {
    final username = usernameController.text;
    final password = passwordController.text;

    if (_formKey.currentState!.validate()) {
      setState(() {
        visible = true;
      });
      try {
        final jwt = await getIt
            .get<Repository>()
            .userRepository
            !.login(username, password);
        if (jwt != null) {
          Navigator.popAndPushNamed(context, HomePage.ROUTE_NAME);
        }
        print(jwt);
        setState(() {
          visible = true;
        });
      } catch (error) {
        print(error);
        if ((error as RequestError).error == 'Unauthorized') {
          setState(() {
            visible = false;
          });
          showCustomDialog(
            context: context,
            type: CustomDialog.ERROR,
            msg: 'Credenziali non corrette!',
          );
        } else {
          setState(() {
            visible = false;
          });
          showCustomDialog(
            context: context,
            type: CustomDialog.ERROR,
            msg: 'errore!',
          );
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance!.addPostFrameCallback((_) async {
      await getIt.get<Repository>().sessionRepository!.init();
      await Future.delayed(Duration(seconds: 1));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Scaffold(
          backgroundColor: Color(0xFFF5F5F5),
          body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 1,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
              child: ListView(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Color(0xFF2CA4D4),
                        ),
                        child: Align(
                          alignment: AlignmentDirectional(0, 0),
                          child: Image.asset(
                            'images/pittogramma-logo-deltacall-check.png',
                            width: 180,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Color(0xFF6FBCDB),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(30, 50, 30, 50),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: usernameController,
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: 'User',
                              labelStyle: FlutterFlowTheme.bodyText1.override(
                                fontFamily: 'Open Sans',
                                color: Color(0xFF707070),
                              ),
                              hintText: 'Nome',
                              hintStyle: FlutterFlowTheme.bodyText1.override(
                                fontFamily: 'Open Sans',
                                color: Color(0xFF707070),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFF2684AA),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFF2684AA),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            style: FlutterFlowTheme.bodyText1.override(
                              fontFamily: 'Open Sans',
                              color: Color(0xFF707070),
                            ),
                            textAlign: TextAlign.start,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return 'Inserire il nome';
                              }
                              if (val.length < 2) {
                                return 'Inserire il nome correttamente';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(30, 0, 30, 50),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              labelStyle: FlutterFlowTheme.bodyText1.override(
                                fontFamily: 'Open Sans',
                                color: Color(0xFF707070),
                              ),
                              hintText: 'password',
                              hintStyle: FlutterFlowTheme.bodyText1.override(
                                fontFamily: 'Open Sans',
                                color: Color(0xFF707070),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFF2684AA),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFF2684AA),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            style: FlutterFlowTheme.bodyText1.override(
                              fontFamily: 'Open Sans',
                              color: Color(0xFF707070),
                            ),
                            keyboardType: TextInputType.visiblePassword,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return 'Inserire Password';
                              }
                              if (val.length < 5) {
                                return 'Inserire la password correttamente';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  CustomButtonPrimary(
                      color: Colors.lightBlueAccent,
                      pressed: onSubmit,
                      content: Text(
                        'Accedi',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                    child: FFButtonWidget(
                      onPressed: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SchedaControlliSceltaWidget(),
                          ),
                        );
                      },
                      text: 'Recupera password',
                      options: FFButtonOptions(
                        width: 170,
                        height: 40,
                        color: Color(0xFF707070),
                        textStyle: FlutterFlowTheme.subtitle2.override(
                          fontFamily: 'Open Sans',
                          color: Colors.white,
                          fontSize: 14,
                        ),
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 1,
                        ),
                        borderRadius: 12,
                      ),
                    ),
                  ),
                  Expanded(
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 45,
                            decoration: BoxDecoration(
                              color: Color(0xFF6FBCDB),
                            ),
                          ),
                        ],
                      ),
                    ),

                ],
              ),
            ),
          ),
        );
  }
}
