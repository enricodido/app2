import 'package:auto_size_text/auto_size_text.dart';
import 'package:checklist/blocs/get_section.dart';
import 'package:checklist/components/flutter_flow_drop_down.dart';
import 'package:checklist/components/flutter_flow_icon_button.dart';
import 'package:checklist/components/flutter_flow_theme.dart';
import 'package:checklist/components/flutter_flow_util.dart';
import 'package:checklist/components/flutter_flow_widget.dart';
import 'package:checklist/model/user.dart';
import 'package:checklist/model/vehicle.dart';
import 'package:checklist/page/items/item.dart';
import 'package:checklist/page/other/popupSignature.dart';
import 'package:checklist/repositories/repository.dart';
import 'package:checklist/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../main.dart';
import '../auth/login.dart';

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
      BlocProvider.of<GetSectionBloc>(context)
          .add(GetSectionBlocRefreshEvent());
      BlocProvider.of<GetSectionBloc>(context)
          .add(GetSectionBlocGetEvent(checklist_id: checklist_id));
    });
  }

  void logout(BuildContext context) {
    getIt.get<Repository>().sessionRepository!.logout();
    Navigator.pushNamedAndRemoveUntil(
        context, LoginPageWidget.ROUTE_NAME, ModalRoute.withName('/'));
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
                ),
              ],
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text('Seleziona Mezzo'),
                  Align(
                    alignment: AlignmentDirectional(-0.05, 0.05),
                  
                    child:
                    
                    FlutterFlowDropDown(
                          options: ['vehicles'].toList(),
                          onChanged: (val) => setState(() => dropDownValue = val),
                          width: 290,
                          height: 50,
                          textStyle: FlutterFlowTheme.subtitle2.override(
                            fontFamily: 'Poppins',
                            color: Colors.lightBlue,
                            fontWeight: FontWeight.w600,
                          ),
                          
                          fillColor: FlutterFlowTheme.tertiaryColor,
                          elevation: 2,
                          borderColor: Colors.lightBlue,
                          borderWidth: 3,
                          borderRadius: 15,
                          margin: EdgeInsetsDirectional.fromSTEB(12, 4, 12, 4),
                          hidesUnderline: true,
                        )
                  ),
                ],
              ),
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
        ));
  }
}
