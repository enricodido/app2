import 'package:checklist/components/flutter_flow_icon_button.dart';
import 'package:checklist/components/flutter_flow_theme.dart';
import 'package:checklist/components/flutter_flow_util.dart';
import 'package:checklist/components/flutter_flow_widget.dart';
import 'package:checklist/page/other/popupSignature.dart';
import 'package:checklist/page/other/sanitaryEquipment.dart';
import 'package:checklist/page/other/variousMaterial.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'backpack.dart';

class SchedaControlloInfermiereWidget extends StatefulWidget {

  @override
  _SchedaControlloInfermiereWidgetState createState() =>
      _SchedaControlloInfermiereWidgetState();
}

class _SchedaControlloInfermiereWidgetState
    extends State<SchedaControlloInfermiereWidget> {
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
              padding: EdgeInsetsDirectional.fromSTEB(20, 10, 20, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 30),
                    child: Text(
                      'Scheda controllo\ninfermiere',
                      textAlign: TextAlign.start,
                      style: FlutterFlowTheme.bodyText1.override(
                        fontFamily: 'Open Sans',
                        color: Color(0xFF2684AA),
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  FaIcon(
                    FontAwesomeIcons.userNurse,
                    color: Color(0xFF2CA4D4),
                    size: 60,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
              child: Text(
                'Effettua la verifica di inizio turno',
                style: FlutterFlowTheme.bodyText1.override(
                  fontFamily: 'Open Sans',
                  color: Color(0xFFBDBDBD),
                  fontSize: 18,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(10, 25, 10, 0),
              child: FFButtonWidget(
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          SchedaControlloMaterialeVarioWidget(),
                    ),
                  );
                },
                text: 'Materiale vario',
                options: FFButtonOptions(
                  width: double.infinity,
                  height: 90,
                  color: Colors.white,
                  textStyle: FlutterFlowTheme.subtitle2.override(
                    fontFamily: 'Open Sans',
                    color: FlutterFlowTheme.primaryColor,
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
              padding: EdgeInsetsDirectional.fromSTEB(10, 25, 10, 0),
              child: FFButtonWidget(
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SchedaControlloZainoWidget(),
                    ),
                  );
                },
                text: 'Zaino',
                options: FFButtonOptions(
                  width: double.infinity,
                  height: 90,
                  color: Colors.white,
                  textStyle: FlutterFlowTheme.subtitle2.override(
                    fontFamily: 'Open Sans',
                    color: FlutterFlowTheme.primaryColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                  borderSide: BorderSide(
                    color: FlutterFlowTheme.primaryColor,
                    width: 3,
                  ),
                  borderRadius: 15,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(10, 25, 10, 0),
              child: FFButtonWidget(
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          SchedaControlloPresidiApparecchiatureSanitarieWidget(),
                    ),
                  );
                },
                text: 'Presidi/apparecchiature sanitarie',
                options: FFButtonOptions(
                  width: double.infinity,
                  height: 90,
                  color: Colors.white,
                  textStyle: FlutterFlowTheme.subtitle2.override(
                    fontFamily: 'Poppins',
                    color: Color(0xFF2FD42C),
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                  borderSide: BorderSide(
                    color: Color(0xFF2FD42C),
                    width: 3,
                  ),
                  borderRadius: 15,
                ),
              ),
            ),
            Expanded(
              child: Align(
                alignment: AlignmentDirectional(0, 1),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FlutterFlowIconButton(
                        borderColor: Colors.transparent,
                        borderRadius: 30,
                        borderWidth: 1,
                        buttonSize: 60,
                        fillColor: FlutterFlowTheme.secondaryColor,
                        icon: Icon(
                          Icons.arrow_back_rounded,
                          color: FlutterFlowTheme.tertiaryColor,
                          size: 40,
                        ),
                        onPressed: () async {
                          Navigator.pop(context);
                        },
                      ),
                      FFButtonWidget(
                        onPressed: () async {
                          await Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.bottomToTop,
                              duration: Duration(milliseconds: 600),
                              reverseDuration: Duration(milliseconds: 600),
                              child: PopUpFirmaWidget(),
                            ),
                          );
                        },
                        text: 'Firma',
                        options: FFButtonOptions(
                          width: 155,
                          height: 60,
                          color: FlutterFlowTheme.primaryColor,
                          textStyle: FlutterFlowTheme.subtitle2.override(
                            fontFamily: 'Open Sans',
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                          ),
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 1,
                          ),
                          borderRadius: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}