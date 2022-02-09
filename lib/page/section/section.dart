import 'dart:async';
import 'dart:typed_data';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:checklist/blocs/get_section.dart';
import 'package:checklist/blocs/get_vehicle.dart';
import 'package:checklist/components/flutter_flow_icon_button.dart';
import 'package:checklist/components/flutter_flow_theme.dart';
import 'package:checklist/components/flutter_flow_widget.dart';
import 'package:checklist/model/user.dart';
import 'package:checklist/model/vehicle.dart';
import 'package:checklist/page/homePage/home.dart';
import 'package:checklist/page/items/item.dart';
import 'package:checklist/repositories/repository.dart';
import 'package:checklist/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';
import '../../main.dart';
import '../auth/login.dart';
import 'dart:ui' as ui;

class SectionWidgetArg {
  SectionWidgetArg({required this.user, required this.checklist_id});

  final UserModel? user;
  final String? checklist_id;
}

class SectionWidget extends StatefulWidget {
  static const ROUTE_NAME = '/section';

  @override
  _SectionWidgetState createState() => _SectionWidgetState();
}

class _SectionWidgetState extends State<SectionWidget> {
  GlobalKey<SfSignaturePadState> signatureGlobalKey = GlobalKey();

  TextEditingController textFieldCausalController = TextEditingController();
String? dropDownValue;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  UserModel? user;
  late String checklist_id;

  Vehicle? selectedVehicle;
  List<Vehicle> vehicles = [];

 


  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance!.addPostFrameCallback((_) async {
      setState(() {
        final args =
            ModalRoute.of(context)!.settings.arguments as SectionWidgetArg;
        user = args.user;
        checklist_id = args.checklist_id!;

        
      });
      BlocProvider.of<GetSectionBloc>(context).add(GetSectionBlocRefreshEvent());
      BlocProvider.of<GetSectionBloc>(context).add(GetSectionBlocGetEvent(checklist_id: checklist_id));

      BlocProvider.of<GetVehicleBloc>(context).add(GetVehicleBlocRefreshEvent());
      BlocProvider.of<GetVehicleBloc>(context).add(GetVehicleBlocGetEvent());
      
    });

    
  }
  void SaveSignature(String checklist_id, String signature) async {

     getIt.get<Repository>().checklistModelRepository!.signature(context, checklist_id.toString(), signature);

}
  void logout(BuildContext context) {
    getIt.get<Repository>().sessionRepository!.logout();
    Navigator.pushNamedAndRemoveUntil(
        context, LoginPageWidget.ROUTE_NAME, ModalRoute.withName('/'));
  }

void recordVehicle(String checklist, Vehicle vehicle) {
  getIt.get<Repository>().checklistModelRepository!.vehicle(context, checklist.toString(), vehicle.id.toString());
}
  
  void close(String checklist) {
    getIt.get<Repository>().checklistModelRepository!.close(context, checklist_id.toString());
 }

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
          child: Column(mainAxisSize: MainAxisSize.max, children: [
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
                                        FFButtonWidget(
                                          onPressed: () {
                                            logout(context);
                                          },
                                          text: 'logout',
                                          options: FFButtonOptions(
                                            width: double.infinity,
                                            height: 45,
                                            color: Colors.lightBlueAccent,
                                            textStyle: FlutterFlowTheme
                                                .subtitle2
                                                .override(
                                              fontFamily: 'Poppins',
                                              color: Colors.white,
                                            ),
                                            borderSide: BorderSide(
                                              color: Colors.transparent,
                                              width: 1,
                                            ),
                                            borderRadius: 12,
                                          ),
                                        ),
                                         FFButtonWidget(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                text: 'Annulla',
                                                options:
                                                FFButtonOptions(
                                                  width:
                                                  double.infinity,
                                                  height: 45,
                                                  color: Colors
                                                      .red,
                                                  textStyle:
                                                  FlutterFlowTheme
                                                      .subtitle2
                                                      .override(
                                                    fontFamily:
                                                    'Poppins',
                                                    color: Colors.white,
                                                  ),
                                                  borderSide:
                                                  BorderSide(
                                                    color: Colors
                                                        .transparent,
                                                    width: 1,
                                                  ),
                                                  borderRadius: 12,
                                                ),
                                              ),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: Text(
                                user!.name + ' ' + user!.lastname ,
                                textAlign: TextAlign.right,
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
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'SCEGLI SEZIONE DA CONTROLLARE',
                          textAlign: TextAlign.center,
                          style: FlutterFlowTheme.bodyText1.override(
                            fontFamily: 'Poppins',
                            color: Color(0xFF005679),
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text('Seleziona Mezzo', ),
                  Align(
                    alignment: AlignmentDirectional(-0.05, 0.05),
                  
                    child: BlocBuilder<GetVehicleBloc, GetVehicleBlocState>(
                  builder: (context, state) {
                if (state is GetVehicleBlocStateLoading)
                  return Center(child: CircularProgressIndicator());
                else {
                  final vehicles =
                      (state as GetVehicleBlocStateLoaded).vehicles;
                  if (vehicles.isNotEmpty) {
                    return DropdownButton<Vehicle>(
                                isExpanded: false,
                                value: selectedVehicle,
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
                                onChanged: (Vehicle? value) async {
                                  setState(() {
                                    selectedVehicle = value;
                                  });
                                recordVehicle(checklist_id, value!);
                                },
                                items: vehicles.map<DropdownMenuItem<Vehicle>>((Vehicle vehicle) {
                                  return DropdownMenuItem<Vehicle>(
                                    value: vehicle,
                                  child: Text(
                                    vehicle.description,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.lightBlue,
                                      fontFamily: 'Open Sans'
                                    ),
                                    ),
                                  );
                                }).toList(),
                              );
                  
                  } else {
                    return Text('Nessun Mezzo');
                  }
                }},
              
                )
              ),
            
            Expanded(
              child: BlocBuilder<GetSectionBloc, GetSectionBlocState>(
                  builder: (context, state) {
                if (state is GetSectionBlocStateLoading)
                  return Center(child: CircularProgressIndicator());
                else {
                  final sections =
                      (state as GetSectionBlocStateLoaded).sections;
                  if (sections.isNotEmpty) {
                    return ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: sections.length,
                        itemBuilder: (context, index) {
                          final section = sections[index];

                          return Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(7, 30, 7, 0),
                            child: FFButtonWidget(
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, ItemWidget.ROUTE_NAME,
                                    arguments: ItemWidgetArg(
                                        user: user, section: section));
                              },
                              text: section.description,
                              options: FFButtonOptions(
                                width: double.infinity,
                                height: 75,
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
                          );
                        });
                  } else {
                    return Container(
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Icon(
                                FontAwesomeIcons.folderOpen,
                                color: firstColor,
                                size: 50,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: AutoSizeText(
                                'NESSUN ELEMENTO',
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                }
              }),
            ),
            Align(
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
                            fillColor: Colors.lightBlueAccent,
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
                              await showDialog(context: context, builder: (AlertDialogContext) {
                                return Dialog(
insetPadding: EdgeInsets.all(10),
child:  Container(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(10),
                child: Center(
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                     SfSignaturePad(
                       key: signatureGlobalKey,
                      backgroundColor: Colors.grey,
                      strokeColor: Colors.black,
                      minimumStrokeWidth: 3.0,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        /*final data = await _signaturePadStateKey.currentState!.toImage();
                        final bytes = await data.toByteData(format: ui.ImageByteFormat.png);
                         Image image = Image.memory(bytes!.buffer.asUint8List());
                        final File file = await file.writeAsBytes(bytes!.buffer.asUint8List(), flush: true);

                         ui.Image image = await _signaturePadStateKey.currentState!.toImage();
                         final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
                         final Uint8List imageBytes = byteData!.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes);

                        final String path = (await getApplicationSupportDirectory()).path;
                        final File file = File(fileName);
                        await file.writeAsBytes(imageBytes, flush: true);*/
                          final image = await signatureGlobalKey.currentState!.toImage();
                          final imageSignature = await image.toByteData(format: ui.ImageByteFormat.png);
                        SaveSignature(checklist_id, imageSignature.toString());
                       //signatureGlobalKey.currentState!.clear();
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
                                  onPressed: () async {
                                      final image = await signatureGlobalKey.currentState!.toImage();
                                      final signature = await image.toByteData(format: ui.ImageByteFormat.png);
                                      SaveSignature(checklist_id, signature.toString());
                        
                                      close(checklist_id);
                         
                                Navigator.popAndPushNamed(context, HomePageWidget.ROUTE_NAME);
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

    ),
                                );

                              }
                              );
                              },
                            text: 'Firma',
                            options: FFButtonOptions(
                              width: 155,
                              height: 60,
                              color: Colors.lightBlueAccent,
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
                    ))
          ]),
        )
        ]
        )
          )
          );
    
    }
}
