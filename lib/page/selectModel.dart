import 'package:checklist/components/flutter_flow_theme.dart';
import 'package:checklist/components/flutter_flow_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'ambulanceModel.dart';
import 'nurseModel.dart';

class SchedaControlliSceltaWidget extends StatefulWidget {
  static const ROUTE_NAME = '/selectModel';

  @override
  _SchedaControlliSceltaWidgetState createState() =>
      _SchedaControlliSceltaWidgetState();
}

class _SchedaControlliSceltaWidgetState
    extends State<SchedaControlliSceltaWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  height: 90,
                  decoration: BoxDecoration(
                    color: Color(0xFF2CA4D4),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
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
                            EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                            child: InkWell(
                              onTap: () async {
                                await showDialog(
                                  context: context,
                                  builder: (alertDialogContext) {
                                    return AlertDialog(
                                      title: Text('Logout'),
                                      content:
                                      Text('Vuoi effettuare il logOut?'),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(alertDialogContext),
                                          child: Text('Ok'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: Text(
                                'Massimiliano\nRossini',
                                textAlign: TextAlign.center,
                                style: FlutterFlowTheme.bodyText1.override(
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
                  width: MediaQuery.of(context).size.width,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Color(0xFF6FBCDB),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 30),
              child: Text(
                'Benvenuto \nMassimiliano \nRossini',
                textAlign: TextAlign.center,
                style: FlutterFlowTheme.bodyText1.override(
                  fontFamily: 'Open Sans',
                  color: Color(0xFF2684AA),
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              'Seleziona la scheda da controllare',
              style: FlutterFlowTheme.bodyText1.override(
                fontFamily: 'Open Sans',
                color: Color(0xFFBDBDBD),
                fontSize: 18,
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(7, 60, 7, 0),
              child: FFButtonWidget(
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SchedaControlloAutomezzoWidget(),
                    ),
                  );
                },
                text: 'Scheda controllo automezzo',
                icon: FaIcon(
                  FontAwesomeIcons.ambulance,
                  size: 30,
                ),
                options: FFButtonOptions(
                  width: double.infinity,
                  height: 90,
                  color: Colors.white,
                  textStyle: FlutterFlowTheme.subtitle2.override(
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
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(7, 30, 7, 0),
              child: FFButtonWidget(
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SchedaControlloInfermiereWidget(),
                    ),
                  );
                },
                text: 'Scheda controllo infermiere',
                icon: FaIcon(
                  FontAwesomeIcons.userNurse,
                  size: 30,
                ),
                options: FFButtonOptions(
                  width: double.infinity,
                  height: 90,
                  color: Colors.white,
                  textStyle: FlutterFlowTheme.subtitle2.override(
                    fontFamily: 'Open Sans',
                    color: Color(0xFFBDBDBD),
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                  borderSide: BorderSide(
                    color: Color(0xFFBDBDBD),
                    width: 3,
                  ),
                  borderRadius: 15,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}