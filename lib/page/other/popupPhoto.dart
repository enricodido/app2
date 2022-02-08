

import 'dart:typed_data';
import 'dart:io';
import 'package:checklist/components/flutter_flow_theme.dart';
import 'package:checklist/components/flutter_flow_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PopUpFirmaFotoWidget extends StatefulWidget {


  @override
  _PopUpFirmaFotoWidgetState createState() => _PopUpFirmaFotoWidgetState();
}

class _PopUpFirmaFotoWidgetState extends State<PopUpFirmaFotoWidget> {
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
                    padding: EdgeInsetsDirectional.fromSTEB(10, 15, 10, 10),
                    child: Text(
                      'Foto aggiunte corretamente',
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

                        // SALVATAGGIO FIRMA SUL DISPOSITIVO


                         
                         ui.Image image = await _signaturePadStateKey.currentState!.toImage();
                         final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
                         final Uint8List imageBytes = byteData!.buffer.asUint8List(byteData.offsetInBytes, byteData.lenghtInBytes);

                        final String path = (await getApplicationSupportDirectory()).path;
                        final File file = File(fileName);
                        await file.writeAsBytes(imageBytes, flush: true);
                        OpenFile.open(fileName); 

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
