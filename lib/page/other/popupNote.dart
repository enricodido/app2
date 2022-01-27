

import 'package:checklist/components/flutter_flow_theme.dart';
import 'package:checklist/components/flutter_flow_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PopUpNoteWidget extends StatefulWidget {

  @override
  _PopUpNoteWidgetState createState() => _PopUpNoteWidgetState();
}

class _PopUpNoteWidgetState extends State<PopUpNoteWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

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
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Align(
              alignment: AlignmentDirectional(0, -1),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(10, 15, 10, 0),
                    child: Text(
                      'Aggiungi una nota',
                      textAlign: TextAlign.center,
                      style: FlutterFlowTheme.bodyText1.override(
                        fontFamily: 'Poppins',
                        color: FlutterFlowTheme.primaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 10),
              child: Text(
                'es. Il Set venoso è stato lasciato sporco',
                style: FlutterFlowTheme.bodyText1.override(
                  fontFamily: 'Open Sans',
                  color: Color(0xFFBDBDBD),
                  fontSize: 16,
                ),
              ),
            ),
            Text(
              'Questo è un Pop-up',
              style: FlutterFlowTheme.bodyText1,
            ),
            Expanded(
              child: Align(
                alignment: AlignmentDirectional(0, 1),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 15),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FFButtonWidget(
                        onPressed: () async {
                          Navigator.pop(context);
                        },
                        text: 'Chiudi',
                        options: FFButtonOptions(
                          width: 135,
                          height: 60,
                          color: Color(0xFFBDBDBD),
                          textStyle: FlutterFlowTheme.subtitle2.override(
                            fontFamily: 'Open Sans',
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 1,
                          ),
                          borderRadius: 12,
                        ),
                      ),
                      FFButtonWidget(
                        onPressed: () async {
                          Navigator.pop(context);
                        },
                        text: 'Salva',
                        options: FFButtonOptions(
                          width: 135,
                          height: 60,
                          color: FlutterFlowTheme.primaryColor,
                          textStyle: FlutterFlowTheme.subtitle2.override(
                            fontFamily: 'Open Sans',
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 1,
                          ),
                          borderRadius: 12,
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
