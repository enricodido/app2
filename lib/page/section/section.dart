import 'dart:async';
import 'dart:io';
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
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';
import '../../components/customDialog.dart';
import '../../main.dart';
import '../auth/login.dart';
import 'dart:ui' as ui;

import '../checklistOpen/checklistOpen.dart';

class SectionWidgetArg {
  SectionWidgetArg(
      {required this.user, required this.checklist_id, required this.selectedVehicle});

  final UserModel? user;
  final String? checklist_id;
  final String? selectedVehicle;
}

class SectionWidget extends StatefulWidget {
  static const ROUTE_NAME = '/section';

  @override
  _SectionWidgetState createState() => _SectionWidgetState();
}

class _SectionWidgetState extends State<SectionWidget> {
  GlobalKey<SfSignaturePadState> signatureGlobalKey = GlobalKey();

  TextEditingController textFieldCausalController = TextEditingController();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  UserModel? user;
  late String checklist_id;

  Vehicle? selectedVehicle;
  String? vehicleId;
  bool isLoading = false;

  

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance!.addPostFrameCallback((_) async {
      setState(() {
        final args =
            ModalRoute.of(context)!.settings.arguments as SectionWidgetArg;
        user = args.user;
        checklist_id = args.checklist_id!;
        
          
        vehicleId = args.selectedVehicle!;
          print(vehicleId); 
      });
      BlocProvider.of<GetSectionBloc>(context)
          .add(GetSectionBlocRefreshEvent());
      BlocProvider.of<GetSectionBloc>(context)
          .add(GetSectionBlocGetEvent(checklist_id: checklist_id));

      BlocProvider.of<GetVehicleBloc>(context)
          .add(GetVehicleBlocRefreshEvent());
      BlocProvider.of<GetVehicleBloc>(context)
          .add(GetVehicleBlocGetEvent(checklist_id: checklist_id));
    });
  }

  void SaveSignature(String checklist_id, File file) async {
    getIt
        .get<Repository>()
        .checklistModelRepository!
        .signature(context, checklist_id.toString(), file);
  }

  void logout(BuildContext context) {
    getIt.get<Repository>().sessionRepository!.logout();
    Navigator.pushNamedAndRemoveUntil(
        context, LoginPageWidget.ROUTE_NAME, ModalRoute.withName('/'));
  }

  void recordVehicle(String checklist, Vehicle vehicle) {
    getIt
        .get<Repository>()
        .checklistModelRepository!
        .vehicle(context, checklist.toString(), vehicle.id.toString());
  }

  void close(String checklist) {
    getIt
        .get<Repository>()
        .checklistModelRepository!
        .close(context, checklist_id.toString());
  }

  Future<void> check(checklist_id) async {
    setState(() {
      isLoading = true;
    });

    try {
      final data = await getIt
          .get<Repository>()
          .checklistModelRepository!
          .check(checklist_id: checklist_id);
      print(checklist_id);
      if (data) {
        await showDialog(
            context: context,
            builder: (AlertDialogContext) {
              return Dialog(
                insetPadding: EdgeInsets.all(10),
                child: Container(
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Center(
                      child: Container(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                  color: Colors.black,
                                  width: 3,
                                )),
                                child: SfSignaturePad(
                                  key: signatureGlobalKey,
                                  backgroundColor: Colors.white,
                                  strokeColor: Colors.black,
                                  minimumStrokeWidth: 3.0,
                                  maximumStrokeWidth: 6,
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  signatureGlobalKey.currentState!.clear();
                                },
                                child: Text('Pulisci'),
                              ),
                              Expanded(
                                child: Align(
                                  alignment: AlignmentDirectional(0, 1),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        10, 10, 10, 15),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
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
                                            textStyle: FlutterFlowTheme
                                                .subtitle2
                                                .override(
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
                                            final image =
                                                await signatureGlobalKey
                                                    .currentState!
                                                    .toImage();
                                            final byteData =
                                                await image.toByteData(
                                                    format:
                                                        ui.ImageByteFormat.png);

                                            var timestamp = DateTime.now()
                                                .millisecondsSinceEpoch
                                                .toString();
                                            Directory appDocDir =
                                                await getApplicationDocumentsDirectory();
                                            String appDocPath = appDocDir.path;
                                            String name = timestamp + '.png';

                                            final file =
                                                File(appDocPath + '/' + name);
                                            await file.writeAsBytes(
                                                byteData!.buffer.asUint8List(
                                                    byteData.offsetInBytes,
                                                    byteData.lengthInBytes));

                                            SaveSignature(checklist_id, file);
                                            close(checklist_id);

                                            Navigator.popAndPushNamed(context,
                                                HomePageWidget.ROUTE_NAME);
                                          },
                                          text: 'Firma ed Esci',
                                          options: FFButtonOptions(
                                            width: 135,
                                            height: 60,
                                            color:
                                                FlutterFlowTheme.primaryColor,
                                            textStyle: FlutterFlowTheme
                                                .subtitle2
                                                .override(
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
                            ]),
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                      ),
                    ),
                  ),
                ),
              );
            });

        setState(() {
          isLoading = false;
        });
      } else {
        showCustomDialog(
          context: context,
          type: CustomDialog.WARNING,
          msg: 'Non hai completato tutte le voci!',
        );
      }
    } catch (error) {
      print(error);
      showCustomDialog(
        context: context,
        type: CustomDialog.WARNING,
        msg: 'Errore!',
      );
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Color(0xFFF5F5F5),
        body: Container(
          margin: const EdgeInsets.only(top: 20.0),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 1,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Column(mainAxisSize: MainAxisSize.max, children: [
              Container(
                child: Row(
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
                            padding:
                                EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
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
                                            title: Text('Vuoi effettuare il logOut?',
                                             textAlign: TextAlign.center,
                                                                    style: FlutterFlowTheme.bodyText1.override(
                                                                      fontFamily: 'Open Sans',
                                                                      color: Colors.blue,
                                                                      fontSize: 20,
                                                                      fontWeight: FontWeight.w600,
                                                                    ),),
                                            content: Container(
                                                    height: 200,
                                                    child:
                                                        SingleChildScrollView(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: <Widget>[
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                            ),
                                                            Column(children: [
                                                            Container(
                                                               width: double
                                                                  .infinity,
                                                              height: 60,
                                                              padding:
                                                                  const EdgeInsets
                                                                          .all(
                                                                      8.0),
                                                              child: 
                                                              
                                                                    ElevatedButton(
                                                                       style: ElevatedButton
                                                                    .styleFrom(
                                                                  primary: Colors
                                                                      .red,
                                                                  // fixedSize: Size(250, 50),
                                                                ),
                                                                  onPressed: () =>
                                                                     logout(context),
                                                                  child: Text(
                                                                    'Si',
                                                                      textAlign: TextAlign.center,
                                                                    style: FlutterFlowTheme.bodyText1.override(
                                                                      fontFamily: 'Open Sans',
                                                                      color: Colors.white,
                                                                      fontSize: 25,
                                                                      fontWeight: FontWeight.w600,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                           
                                                            Container(
                                                              width: double
                                                                  .infinity,
                                                              height: 60,
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                    
                                                                child:ElevatedButton(
                                                               style: ElevatedButton
                                                                    .styleFrom(
                                                                  primary: Colors
                                                                      .blue,),
                                                                  onPressed: () =>
                                                                      Navigator.pop(
                                                                          alertDialogContext),
                                                                  child: Text(
                                                                    'No',
                                                                      textAlign: TextAlign.center,
                                                                    style: FlutterFlowTheme.bodyText1.override(
                                                                      fontFamily: 'Open Sans',
                                                                      color: Colors.white,
                                                                      fontSize: 25,
                                                                      fontWeight: FontWeight.w600,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                             
                                                              ])
                                                            
                                                            ]),
                                          )));
                                        },
                                      );
                                  },
                                  child: Text(
                                    user!.name + '\n' + user!.lastname,
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
              ),
              Container(
                child: Row(
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
              ),
              Expanded(
                child: Container(
                  child: Column(mainAxisSize: MainAxisSize.max, children: [
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      FaIcon(
                        FontAwesomeIcons.ambulance,
                        color: Color(0xFF2CA4D4),
                        size: 40,
                      ),
                      BlocBuilder<GetVehicleBloc, GetVehicleBlocState>(
                        builder: (context, state) {
                          if (state is GetVehicleBlocStateLoading)
                            return Center(child: CircularProgressIndicator());
                          else {
                            List<Vehicle> vehicles =
                                (state as GetVehicleBlocStateLoaded).vehicles;
                            if (vehicleId != null) {
                              String? val = vehicleId!;
                              if (vehicles.length > 0) {
                                vehicles.forEach((vehicle) {
                                  if (val == vehicle.description) {
                                    selectedVehicle = vehicle;
                                  }
                                });
                              }
                            }
                            if (vehicles.isNotEmpty) {
                              return DropdownButton<Vehicle>(
                                hint: Text('Seleziona Mezzo'),
                                isExpanded: false,
                                value: selectedVehicle,
                                icon: const Icon(Icons.arrow_drop_down),
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
                                onChanged: (Vehicle? value) {
                                  setState(() {
                                    selectedVehicle = value;
                                    vehicleId = selectedVehicle!.id;
                                  });
                                  recordVehicle(checklist_id, value!);
                                },
                                items: vehicles.map<DropdownMenuItem<Vehicle>>(
                                    (Vehicle vehicle) {
                                  return DropdownMenuItem<Vehicle>(
                                    value: vehicle,
                                    child: Text(
                                      vehicle.description,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.lightBlue,
                                          fontFamily: 'Open Sans'),
                                    ),
                                  );
                                }).toList(),
                              );
                            } else {
                              return Text('Nessun Mezzo');
                            }
                          }
                        },
                      )
                    ]),
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
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        7, 30, 7, 0),
                                    child: FFButtonWidget(
                                      onPressed: () {
                                        if (vehicleId != 'Non selezionato' && vehicleId != 'Seleziona Mezzo') {
                                     Navigator.pushNamed(
                                            context, ItemWidget.ROUTE_NAME,
                                            arguments: ItemWidgetArg(
                                                user: user, section: section, selectedVehicle: selectedVehicle!.description));
                                    } else {
                                      showCustomDialog(
                                          context: context,
                                          type: CustomDialog.ERROR,
                                          msg:
                                              'Attenzione!\nselezionare un mezzo per continuare!');
                                    }
                                        
                                      },
                                      text: section.description,
                                      options: FFButtonOptions(
                                        width: double.infinity,
                                        height: 75,
                                        color: Colors.white,                                 
                                        textStyle:                                        
                                          FlutterFlowTheme.subtitle2.override(
                                          fontFamily: 'Open Sans',
                                          color: section.done ? Colors.green : Color(0xFF2CA4D4),
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        borderSide: BorderSide(
                                          color: section.done ? Colors.green : Color(0xFF2CA4D4),
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
                    Container(
                      child: Align(
                          alignment: AlignmentDirectional(0, 1),
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
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
                                    await showDialog(
                                        context: context,
                                        builder: (alertDialogContext) {
                                          return AlertDialog(
                                            title: Text('Sicuro di voler tornare indietro?',
                                             textAlign: TextAlign.center,
                                                                    style: FlutterFlowTheme.bodyText1.override(
                                                                      fontFamily: 'Open Sans',
                                                                      color: Colors.blue,
                                                                      fontSize: 20,
                                                                      fontWeight: FontWeight.w600,
                                                                    ),),
                                            content: Container(
                                                    height: 200,
                                                    child:
                                                        SingleChildScrollView(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: <Widget>[
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                            ),
                                                            Column(children: [
                                                            Container(
                                                               width: double
                                                                  .infinity,
                                                              height: 60,
                                                              padding:
                                                                  const EdgeInsets
                                                                          .all(
                                                                      8.0),
                                                              child: 
                                                                    ElevatedButton(
                                                                      style: ElevatedButton
                                                                    .styleFrom(
                                                                  primary: Colors
                                                                      .red,
                                                                  // fixedSize: Size(250, 50),
                                                                ),
                                                                  onPressed: () =>
                                                                     Navigator.pushNamed(context, ChecklistAperteWidget.ROUTE_NAME, arguments: ChecklistAperteWidgetArg(user: user)),
                                                                  child: Text(
                                                                    'Si',
                                                                      textAlign: TextAlign.center,
                                                                    style: FlutterFlowTheme.bodyText1.override(
                                                                      fontFamily: 'Open Sans',
                                                                      color: Colors.white,
                                                                      fontSize: 25,
                                                                      fontWeight: FontWeight.w600,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                           
                                                            Container(
                                                              width: double
                                                                  .infinity,
                                                              height: 60,
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                    
                                                                child:
                                                                    ElevatedButton(
                                                                       style: ElevatedButton
                                                                    .styleFrom(
                                                                  primary: Colors
                                                                      .blue,
                                                                ),
                                                                  onPressed: () =>
                                                                      Navigator.pop(
                                                                          alertDialogContext),
                                                                  child: Text(
                                                                    'No',
                                                                      textAlign: TextAlign.center,
                                                                    style: FlutterFlowTheme.bodyText1.override(
                                                                      fontFamily: 'Open Sans',
                                                                      color: Colors.white,
                                                                      fontSize: 25,
                                                                      fontWeight: FontWeight.w600,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                             
                                                              ])
                                                            
                                                            ]),
                                          )));
                                        },
                                      );
}
  
                                /*  onPressed: () async {
                                    Navigator.pushNamed(context, HomePageWidget.ROUTE_NAME);
                                  },*/
                                ),
                                FFButtonWidget(
                                  onPressed: () async {
                                    if (vehicleId != 'Non selezionato' && vehicleId != 'Seleziona Mezzo') {
                                    //  check(checklist_id);
showDialog(
            context: context,
            builder: (AlertDialogContext) {
              return Dialog(
                insetPadding: EdgeInsets.all(10),
                child: Container(
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Center(
                      child: Container(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                  color: Colors.black,
                                  width: 3,
                                )),
                                child: SfSignaturePad(
                                  key: signatureGlobalKey,
                                  backgroundColor: Colors.white,
                                  strokeColor: Colors.black,
                                  minimumStrokeWidth: 3.0,
                                  maximumStrokeWidth: 6,
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  signatureGlobalKey.currentState!.clear();
                                },
                                child: Text('Pulisci'),
                              ),
                              Expanded(
                                child: Align(
                                  alignment: AlignmentDirectional(0, 1),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        10, 10, 10, 15),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
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
                                            textStyle: FlutterFlowTheme
                                                .subtitle2
                                                .override(
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
                                            final image =
                                                await signatureGlobalKey
                                                    .currentState!
                                                    .toImage();
                                            final byteData =
                                                await image.toByteData(
                                                    format:
                                                        ui.ImageByteFormat.png);

                                            var timestamp = DateTime.now()
                                                .millisecondsSinceEpoch
                                                .toString();
                                            Directory appDocDir =
                                                await getApplicationDocumentsDirectory();
                                            String appDocPath = appDocDir.path;
                                            String name = timestamp + '.png';

                                            final file =
                                                File(appDocPath + '/' + name);
                                            await file.writeAsBytes(
                                                byteData!.buffer.asUint8List(
                                                    byteData.offsetInBytes,
                                                    byteData.lengthInBytes));

                                            SaveSignature(checklist_id, file);
                                            close(checklist_id);

                                            Navigator.popAndPushNamed(context,
                                                HomePageWidget.ROUTE_NAME);
                                          },
                                          text: 'Firma ed Esci',
                                          options: FFButtonOptions(
                                            width: 135,
                                            height: 60,
                                            color:
                                                FlutterFlowTheme.primaryColor,
                                            textStyle: FlutterFlowTheme
                                                .subtitle2
                                                .override(
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
                            ]),
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                      ),
                    ),
                  ),
                ),
              );
            });

                                    } else {
                                      showCustomDialog(
                                          context: context,
                                          type: CustomDialog.ERROR,
                                          msg:
                                              'Attenzione!\nselezionare un mezzo per continuare!');
                                    }
                                  },
                                  text: 'Firma',
                                  options: FFButtonOptions(
                                    width: 155,
                                    height: 60,
                                    color: Colors.lightBlueAccent,
                                    textStyle:
                                        FlutterFlowTheme.subtitle2.override(
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
                          )),
                    )
                  ]),
                ),
              )
            ])))
    );
  }
}
