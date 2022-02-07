import 'dart:typed_data';
import 'dart:io';
import 'package:checklist/components/flutter_flow_theme.dart';
import 'package:checklist/components/flutter_flow_widget.dart';
import 'package:checklist/model/checklist.dart';
import 'package:checklist/page/homePage/home.dart';
import 'package:checklist/repositories/repository.dart';
import 'package:flutter/scheduler.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'package:universal_html/html.dart' show AnchorElement;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:convert';

import '../../main.dart';

class PopUpFirmaWidgetArg {
  PopUpFirmaWidgetArg({
    required this.checklist,
  });

  final ChecklistModel? checklist;
}

class PopUpFirmaWidget extends StatefulWidget {
  static const ROUTE_NAME = '/signature';

  
  @override
  _PopUpFirmaWidgetState createState() => _PopUpFirmaWidgetState();
}

class _PopUpFirmaWidgetState extends State<PopUpFirmaWidget> {
  GlobalKey<SfSignaturePadState> _signaturePadStateKey = GlobalKey();

late ChecklistModel checklist;

@override
  void initState() {
    super.initState();


      SchedulerBinding.instance!.addPostFrameCallback((_) async {
        setState(() {
        final args = ModalRoute.of(context)!.settings.arguments as PopUpFirmaWidgetArg;
        checklist = args.checklist!;
        });
      });
}
 void close(ChecklistModel checklist) {
    getIt.get<Repository>().checklistModelRepository!.close(context, checklist.id.toString());
 }

      
 
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
                child: Center(
                  child: Container(
                    child: Column(
                      verticalDirection: VerticalDirection.down,
                      children: [
                     SfSignaturePad(
                       key: _signaturePadStateKey,
                      backgroundColor: Colors.grey,
                      strokeColor: Colors.black,
                      minimumStrokeWidth: 3.0,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                       _signaturePadStateKey.currentState!.clear();
                      },
                      child: Text('Pulisci'),
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
                                  onPressed: ()  {
                                    close(checklist);
                                  },
                                  text: 'Firma ed Esci',
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
                    ]
                
                    ),
                    height: MediaQuery.of(context).size.height,
                    width:  MediaQuery.of(context).size.width,
                    
                  ),
                ),
      ),

    );


  }
}
