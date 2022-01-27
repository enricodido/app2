import 'package:auto_size_text/auto_size_text.dart';
import 'package:checklist/blocs/get_item.dart';
import 'package:checklist/components/flutter_flow_icon_button.dart';
import 'package:checklist/components/flutter_flow_radio_button.dart';
import 'package:checklist/components/flutter_flow_theme.dart';
import 'package:checklist/components/flutter_flow_widget.dart';
import 'package:checklist/model/section.dart';
import 'package:checklist/model/user.dart';
import 'package:checklist/page/auth/login.dart';
import 'package:checklist/repositories/repository.dart';
import 'package:checklist/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../main.dart';

class ItemWidgetArg {
  ItemWidgetArg({
    required this.user,
    required this.section_id,
    required this.section,
  });

  final UserModel? user;
  final String? section_id;
  final Section section;
}

class ItemWidget extends StatefulWidget {
  static const ROUTE_NAME = '/item';

  @override
  _ItemWidgetState createState() => _ItemWidgetState();
}

class _ItemWidgetState extends State<ItemWidget> {
  bool checkboxFalse = false;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  UserModel? user;
  String? section_id;
  Section? section;

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance!.addPostFrameCallback((_) async {
      setState(() {
        final args =
            ModalRoute.of(context)!.settings.arguments as ItemWidgetArg;
        user = args.user;
        section_id = args.section_id;
        section = args.section;
      });
      BlocProvider.of<GetItemBloc>(context).add(GetItemBlocRefreshEvent());
      BlocProvider.of<GetItemBloc>(context)
          .add(GetItemBlocGetEvent(section_id: section_id));
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
                          section!.description,
                          textAlign: TextAlign.start,
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
              // width: MediaQuery.of(context).size.width,
              // margin: EdgeInsets.only(left: 15.0, right: 15.0),
              child: BlocBuilder<GetItemBloc, GetItemBlocState>(
                  builder: (context, state) {
                if (state is GetItemBlocStateLoading)
                  return Center(child: CircularProgressIndicator());
                else {
                  final items = (state as GetItemBlocStateLoaded).items;
                  if (items.isNotEmpty) {
                    return ListView.builder(
                        physics: AlwaysScrollableScrollPhysics(),
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          final item = items[index];

                          return Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(7, 30, 7, 0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 5, 0, 5),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        item.description,
                                        style:
                                            FlutterFlowTheme.subtitle2.override(
                                          fontFamily: 'Open Sans',
                                          fontSize: 14.5,
                                        ),
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Checkbox(
                                            value: checkboxFalse,
                                            onChanged: (bool? newValue) {
                                              setState(() {
                                                checkboxFalse = !checkboxFalse;
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
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
            Expanded(
              child: Align(
                alignment: AlignmentDirectional(0, 1),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                        child: FlutterFlowIconButton(
                          borderColor: Colors.transparent,
                          borderRadius: 30,
                          borderWidth: 1,
                          buttonSize: 60,
                          fillColor: Colors.lightBlueAccent,
                          icon: Icon(
                            Icons.arrow_back_rounded,
                            color: Colors.white,
                            size: 40,
                          ),
                          onPressed: () async {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                        child: FFButtonWidget(
                          onPressed: () async {
                            Navigator.pop(context);
                          },
                          text: 'Salva',
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
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                        child: FlutterFlowIconButton(
                          borderColor: Colors.transparent,
                          borderRadius: 30,
                          borderWidth: 1,
                          buttonSize: 60,
                          fillColor: Colors.lightBlueAccent,
                          icon: Icon(
                            Icons.add,
                            color: FlutterFlowTheme.tertiaryColor,
                            size: 40,
                          ),
                          onPressed: () async {
                            await showDialog(
                              context: context,
                              builder: (alertDialogContext) {
                                return AlertDialog(
                                  title: Text('PopUp'),
                                  content: Text(
                                      'Inserire icone di : note e telecamera'),
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
