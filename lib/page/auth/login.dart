import 'package:checklist/components/customDialog.dart';
import 'package:checklist/components/flutter_flow_theme.dart';
import 'package:checklist/components/flutter_flow_widget.dart';
import 'package:checklist/page/auth/resetPassword.dart';
import 'package:checklist/page/checklistModels.dart';
import 'package:checklist/page/home.dart';
import 'package:checklist/page/selectModel.dart';
import 'package:checklist/page/user_page_widget.dart';
import 'package:checklist/repositories/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import '../../main.dart';

class LoginPageWidget extends StatefulWidget {
  static const ROUTE_NAME = '/login';
  @override
  _LoginPageWidgetState createState() => _LoginPageWidgetState();
}

class _LoginPageWidgetState extends State<LoginPageWidget> {
  bool isLoading = false;

  TextEditingController textFieldEmailController = TextEditingController();
  TextEditingController textFieldPasswordController = TextEditingController();

  String emailError = 'email richiesta.';
  String passwordError = 'Password richiesta.';

  bool textFieldPasswordVisibility = false;
  bool _loadingButton = false;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  void onSubmit() async {
    final email = textFieldEmailController.text.trim();
    final password = textFieldPasswordController.text.trim();

    print(HOST);

    if (email.isNotEmpty && password.isNotEmpty) {
      setState(() {
        isLoading = true;
      });

      try {

        final jwt = await getIt
            .get<Repository>()
            .userRepository!
            .login(context, email.toString(), password.toString());
        if(jwt != null) {
          Navigator.pushNamed(context, SchedaControlliSceltaWidget.ROUTE_NAME);
        }

      } catch (error) {
        print(error);
        if ((error as RequestError).error == 'Unauthorized') {
          showCustomDialog(
            context: context,
            type: CustomDialog.WARNING,
            msg: 'Credenziali non corrette!',
          );
        }
      }
      setState(() {
        isLoading = false;
      });

    } else {
      showCustomDialog(
        context: context,
        type: CustomDialog.WARNING,
        msg:'Dati mancanti!',
      );
    }
  }

    @override
    void initState() {
      super.initState();
    }

  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidateMode: AutovalidateMode.always,
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Color(0xFFF5F5F5),
        body: Container(
          width: double.infinity,
          height: double.infinity,
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
                child: TextFormField(
                        controller: textFieldEmailController,
                        obscureText: false,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle: FlutterFlowTheme.bodyText1.override(
                            fontFamily: 'Open Sans',
                            color: Color(0xFF707070),
                          ),
                          hintText: 'Inserisci Email',
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
                          contentPadding:
                              EdgeInsetsDirectional.fromSTEB(18, 18, 18, 18),
                          prefixIcon: Icon(
                            Icons.person,
                          ),
                        ),
                        style: FlutterFlowTheme.bodyText1.override(
                          fontFamily: 'Open Sans',
                          color: Color(0xFF707070),
                        ),
                      ),
                    ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(30, 0, 30, 50),
                child: TextFormField(
                        controller: textFieldPasswordController,
                        obscureText: !textFieldPasswordVisibility,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: FlutterFlowTheme.bodyText1.override(
                            fontFamily: 'Open Sans',
                            color: Color(0xFF707070),
                          ),
                          hintText: 'Password',
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
                          contentPadding:
                              EdgeInsetsDirectional.fromSTEB(18, 18, 18, 18),
                          prefixIcon: Icon(
                            Icons.password,
                          ),
                          suffixIcon: InkWell(
                            onTap: () => setState(
                              () => textFieldPasswordVisibility =
                                  !textFieldPasswordVisibility,
                            ),
                            child: Icon(
                              textFieldPasswordVisibility
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                              color: Color(0xFF757575),
                              size: 22,
                            ),
                          ),
                        ),
                        style: FlutterFlowTheme.bodyText1.override(
                          fontFamily: 'Open Sans',
                          color: Color(0xFF707070),
                        ),
                        keyboardType: TextInputType.visiblePassword,
                      ),
                    ),
              Container(
                width: double.infinity,
                height: 25,
                decoration: BoxDecoration(
                  color: Color(0xFFEEEEEE),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                child: FFButtonWidget(
                  onPressed: onSubmit,
                  text: 'Accedi',
                  options: FFButtonOptions(
                    width: double.infinity,
                    height: 45,
                    color: Colors.lightBlueAccent,
                    textStyle: FlutterFlowTheme.subtitle2.override(
                      fontFamily: 'Poppins',
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                    borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 1,
                    ),
                    borderRadius: 15,
                  ),
                  loading: _loadingButton,
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
                child: FFButtonWidget(
                  onPressed: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RecuperaPasswordWidget(),
                      ),
                    );
                  },
                  text: 'Recupera Password',
                  options: FFButtonOptions(
                    width: double.infinity,
                    height: 40,
                    color: Colors.grey,
                    textStyle: FlutterFlowTheme.subtitle2.override(
                      fontFamily: 'Poppins',
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                    borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 1,
                    ),
                    borderRadius: 15,
                  ),
                  loading: _loadingButton,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
