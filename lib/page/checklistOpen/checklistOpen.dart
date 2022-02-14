import 'package:auto_size_text/auto_size_text.dart';
import 'package:checklist/blocs/get_checklist.dart';
import 'package:checklist/blocs/get_model.dart';
import 'package:checklist/components/flutter_flow_theme.dart';
import 'package:checklist/components/flutter_flow_widget.dart';
import 'package:checklist/model/user.dart';
import 'package:checklist/repositories/repository.dart';
import 'package:checklist/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../main.dart';
import '../section/section.dart';
import '../auth/login.dart';

class ChecklistAperteWidgetArg {
  ChecklistAperteWidgetArg({
    required this.user,
  });

  final UserModel? user;
}

class ChecklistAperteWidget extends StatefulWidget {
  static const ROUTE_NAME = '/openchecklist';

  @override
  _ChecklistAperteWidgetState createState() => _ChecklistAperteWidgetState();
}

class _ChecklistAperteWidgetState extends State<ChecklistAperteWidget> {
  TextEditingController textFieldCausalController = TextEditingController();

  final scaffoldKey = GlobalKey<ScaffoldState>();

  UserModel? user;

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance!.addPostFrameCallback((_) async {
      setState(() {
        final args = ModalRoute.of(context)!.settings.arguments
            as ChecklistAperteWidgetArg;
        user = args.user;

        
      });
      BlocProvider.of<GetChecklistBloc>(context)
          .add(GetChecklistBlocRefreshEvent());
      BlocProvider.of<GetChecklistBloc>(context)
          .add(GetChecklistBlocGetEvent());

          
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
        child: Column(
          mainAxisSize: MainAxisSize.max,
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
                                        FFButtonWidget(
                                          onPressed: () {
                                            logout(context);
                                          },
                                          text: 'Logout',
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
                                          options: FFButtonOptions(
                                            width: double.infinity,
                                            height: 45,
                                            color: Colors.red,
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
                                'Logout',
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
                'Benvenuto' + '\n ' + user!.name + ' ' + user!.lastname,
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
              'Non sono state concluse queste schede',
              style: FlutterFlowTheme.bodyText1.override(
                fontFamily: 'Open Sans',
                color: Color.fromARGB(255, 226, 22, 22),
                fontSize: 19,
              ),
            ),
            Expanded(
              // width: MediaQuery.of(context).size.width,
              // margin: EdgeInsets.only(left: 15.0, right: 15.0),
              child: BlocBuilder<GetChecklistBloc, GetChecklistBlocState>(
                  builder: (context, state) {
                if (state is GetChecklistBlocStateLoading)
                  return Center(child: CircularProgressIndicator());
                else {
                  final checklists =
                      (state as GetChecklistBlocStateLoaded).checklists;
                  if (checklists.isNotEmpty) {
                    return ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: checklists.length,
                        itemBuilder: (context, index) {
                          final checklist = checklists[index];

                          return Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                            child: Card(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              color: Color(0xFFE5E5E5),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10, 10, 10, 10),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    RichText(
                                        text: TextSpan(
                                            style: new TextStyle(
                                            fontSize: 22.0,
                                            color: Colors.black,
                                            fontFamily: 'Open Sans'             
                                            ),
                                          children: <TextSpan>[
                                            new TextSpan(text: checklist.model, style: new TextStyle(fontWeight: FontWeight.bold, color: Colors.redAccent)),
                                            new TextSpan(text:     
                                            '\n' +
                                            'Utente: ' + checklist.user.name  + ' ' + checklist.user.lastname + 
                                            '\n' +
                                            'Data: ' +
                                            checklist.created_at +
                                            '\n' +
                                            'Mezzo: ' +
                                            checklist.vehicle_id.toString() ,
                                            ),
                                          ]
                                        ),
                                    ),
     
                                    Align(
                                      alignment: AlignmentDirectional(1, 0),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            10, 5, 10, 0),
                                        child: FFButtonWidget(
                                          onPressed: () {
                                            Navigator.pushNamed(context,
                                                SectionWidget.ROUTE_NAME,
                                                arguments: SectionWidgetArg(
                                                    user: user,
                                                   checklist_id: checklist.id,));
                                          },
                                          text: 'Modifica',
                                          options: FFButtonOptions(
                                            width: 130,
                                            height: 40,
                                            color:
                                                FlutterFlowTheme.secondaryColor,
                                            textStyle: FlutterFlowTheme
                                                .subtitle2
                                                .override(
                                              fontFamily: 'Open Sans',
                                              color: Colors.white,
                                            ),
                                            borderSide: BorderSide(
                                              color: Colors.transparent,
                                              width: 1,
                                            ),
                                            borderRadius: 12,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
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
                                color: Colors.lightBlueAccent,
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
            )
          ],
        ),
      ),
    );
  }
}
