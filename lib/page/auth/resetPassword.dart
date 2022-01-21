import 'package:checklist/components/flutter_flow_theme.dart';
import 'package:checklist/components/flutter_flow_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'login.dart';

class RecuperaPasswordWidget extends StatefulWidget {

  @override
  _RecuperaPasswordWidgetState createState() => _RecuperaPasswordWidgetState();
}

class _RecuperaPasswordWidgetState extends State<RecuperaPasswordWidget> {
  late TextEditingController textController;
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    textController = TextEditingController(text: 'Nome Utente');
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Scaffold(
        key: scaffoldKey,
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
                    height: 230,
                    decoration: BoxDecoration(
                      color: Color(0xFF2CA4D4),
                    ),
                    child: Align(
                      alignment: AlignmentDirectional(0, 0),
                      child: Image.asset(
                        'images/pittogramma-logo-deltacall-check.png',
                        width: 220,
                        fit: BoxFit.cover,
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
                        controller: textController,
                        obscureText: false,
                        decoration: InputDecoration(
                          labelText: 'User',
                          labelStyle: FlutterFlowTheme.bodyText1.override(
                            fontFamily: 'Open Sans',
                            color: Color(0xFF707070),
                          ),
                          hintText: '',
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
                padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                child: FFButtonWidget(
                  onPressed: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginPageWidget(),
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
                child: Align(
                  alignment: AlignmentDirectional(0, 1),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
