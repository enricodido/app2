import 'dart:ffi';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:checklist/blocs/get_item.dart';
import 'package:checklist/blocs/get_text.dart';
import 'package:checklist/components/flutter_flow_icon_button.dart';
import 'package:checklist/components/flutter_flow_theme.dart';
import 'package:checklist/components/flutter_flow_widget.dart';
import 'package:checklist/model/item.dart';
import 'package:checklist/model/section.dart';
import 'package:checklist/model/user.dart';
import 'package:checklist/page/auth/login.dart';
import 'package:checklist/page/homePage/home.dart';
import 'package:checklist/page/section/section.dart';
import 'package:checklist/repositories/repository.dart';
import 'package:checklist/theme/color.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../components/customDialog.dart';
import '../../main.dart';

class ItemWidgetArg {
  ItemWidgetArg({
    required this.user,
    required this.section,
    this.selectedVehicle,
  });

  final UserModel? user;
  String? selectedVehicle;
  Section section;
}

class ItemWidget extends StatefulWidget {
  static const ROUTE_NAME = '/items';

  @override
  _ItemWidgetState createState() => _ItemWidgetState();
}

class _ItemWidgetState extends State<ItemWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool isLoading = false;
  UserModel? user;
  String? selectedVehicle;
  late Section section;
  List<Item> items = [];

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance!.addPostFrameCallback((_) async {
      setState(() {
        final args =
            ModalRoute.of(context)!.settings.arguments as ItemWidgetArg;
        user = args.user;
        section = args.section;
        selectedVehicle = args.selectedVehicle;
      });

      BlocProvider.of<GetItemBloc>(context).add(GetItemBlocRefreshEvent());
      BlocProvider.of<GetItemBloc>(context)
          .add(GetItemBlocGetEvent(section_id: section.id));
    });
  }

  Future<void> check(section_id) async {
    setState(() {
      isLoading = true;
    });

    try {
      final data = await getIt
          .get<Repository>()
          .itemRepository!
          .check(section_id: section.id);
      print(section_id);
      if (data) {
        Navigator.pushNamed(context, SectionWidget.ROUTE_NAME, arguments: SectionWidgetArg(
                                                    user: user,
                                                    checklist_id: section.checklist_id,
                                                    selectedVehicle:  selectedVehicle));
         
        
        setState(() {
          isLoading = false;
        });

        showCustomDialog(
          context: context,
          type: CustomDialog.SUCCESS,
          msg: 'Sezione Completata con Successo',
        );
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

  void logout(BuildContext context) {
    getIt.get<Repository>().sessionRepository!.logout();
    Navigator.pushNamedAndRemoveUntil(
        context, LoginPageWidget.ROUTE_NAME, ModalRoute.withName('/'));
  }

  TextEditingController textFieldNoteController = TextEditingController();
  dynamic recordValue(Item item) async {
    
    return await getIt.get<Repository>().itemRepository!.value(context,
        item.value.toString(), item.working.toString(), item.id.toString());
      
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
                              section.description,
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
                  child: Padding(
                    padding: const EdgeInsets.all(9.0),
                    // width: MediaQuery.of(context).size.width,
                    child: BlocBuilder<GetItemBloc, GetItemBlocState>(
                        builder: (context, state) {
                      if (state is GetItemBlocStateLoading)
                        return Center(child: CircularProgressIndicator());
                      else {
                        final items = (state as GetItemBlocStateLoaded).items;
                        if (items.isNotEmpty) {
                          return ListView.builder(
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              itemCount: items.length,
                              itemBuilder: (context, index) {
                                var item = items[index];
                                Widget icon = Row();
                                switch (item.type) {
                                  case T_BOOL:
                                    icon = Checkbox(
                                      value: item.value == 'true',
                                      activeColor: Colors.blue,
                                      onChanged: (bool? value) async {
                                        setState(() {
                                          bool ActualValue =
                                              item.value == 'true';
                                          ActualValue = !ActualValue;
                                          item.value =
                                              ActualValue ? 'true' : 'false';
                                          item.working =
                                              !ActualValue ? '1' : '0';
                                        });
                                        dynamic response = await recordValue(item);
                                      },
                                    );
                                    break;
                                  case T_TEXT:
                                    icon = FlutterFlowIconButton(
                                      borderColor: Colors.transparent,
                                      borderRadius: 30,
                                      borderWidth: 1,
                                      buttonSize: 40,
                                      fillColor: Colors.lightBlueAccent,
                                      icon: Icon(
                                        Icons.edit,
                                        color: FlutterFlowTheme.tertiaryColor,
                                        size: 20,
                                      ),
                                      onPressed: () async {
                                        await showDialog(
                                          context: context,
                                          builder: (alertDialogContext) {
                                            return AlertDialog(
                                                title: Text(item.description),
                                                content: Container(
                                                    height: 400,
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
                                                            Container(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .all(
                                                                      10.0),
                                                              child: TextField(
                                                                // <-- SEE HERE
                                                                onChanged: (_) =>
                                                                    EasyDebounce
                                                                        .debounce(
                                                                  'textFieldNoteController',
                                                                  Duration(
                                                                      milliseconds:
                                                                          2000),
                                                                  () => setState(
                                                                      () {}),
                                                                ),
                                                                controller:
                                                                    textFieldNoteController,
                                                                decoration:
                                                                    InputDecoration(
                                                                  border:
                                                                      OutlineInputBorder(),
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
                                                                onPressed: () async {
                                                                 print('sant ascanio');
                                                                  item.value =
                                                                      textFieldNoteController
                                                                          .text;
                                                                  print(item.value);
                                                                  item.working =
                                                                      '0';
                                                                 dynamic response = await  recordValue(
                                                                      item); 

                                                                    print(textFieldNoteController.text);     
                                                                 Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                  
                                                                      
                                                                     
                                                                },
                                                                style: ElevatedButton
                                                                    .styleFrom(
                                                                  primary: Colors
                                                                      .green,
                                                                  // fixedSize: Size(250, 50),
                                                                ),
                                                                child:
                                                                    TextButton(
                                                                  onPressed: () =>
                                                                      Navigator.pop(
                                                                          alertDialogContext),
                                                                  child: Text(
                                                                    'Ok',
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ]),
                                                    )));
                                          },
                                        );
                                      },
                                    );
                                    break;
                                  case T_NUMBER:
                                    icon = FlutterFlowIconButton(
                                      borderColor: Colors.transparent,
                                      borderRadius: 30,
                                      borderWidth: 1,
                                      buttonSize: 40,
                                      fillColor: Colors.lightBlueAccent,
                                      icon: Icon(
                                        Icons.edit,
                                        color: FlutterFlowTheme.tertiaryColor,
                                        size: 20,
                                      ),
                                      onPressed: () async {
                                        await showDialog(
                                          context: context,
                                          builder: (alertDialogContext) {
                                            return AlertDialog(
                                                title: Text(item.description),
                                                content: Container(
                                                    height: 400,
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
                                                            Container(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: TextField(
                                                                onChanged: (_) =>
                                                                    EasyDebounce
                                                                        .debounce(
                                                                  'textFieldNoteController',
                                                                  Duration(
                                                                      milliseconds:
                                                                          2000),
                                                                  () => setState(
                                                                      () {}),
                                                                ),
                                                                controller:
                                                                    textFieldNoteController,
                                                                decoration:
                                                                    InputDecoration(
                                                                  border:
                                                                      OutlineInputBorder(),
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
                                                                onPressed: () async {
                                                                  item.value =
                                                                      textFieldNoteController
                                                                          .text;
                                                                  item.working =
                                                                      '0';
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                dynamic response = await   recordValue(
                                                                      item);
                                                                },
                                                                style: ElevatedButton
                                                                    .styleFrom(
                                                                  primary: Colors
                                                                      .black,
                                                                  // fixedSize: Size(250, 50),
                                                                ),
                                                                child:
                                                                    TextButton(
                                                                  onPressed: () =>
                                                                      Navigator.pop(
                                                                          alertDialogContext),
                                                                  child: Text(
                                                                      'Ok'),
                                                                ),
                                                              ),
                                                            ),
                                                          ]),
                                                    )));
                                          },
                                        );
                                      },
                                    );
                                    break;
                                  case T_LIST:
                                    icon = FlutterFlowIconButton(
                                      borderColor: Colors.transparent,
                                      borderRadius: 30,
                                      borderWidth: 1,
                                      buttonSize: 40,
                                      fillColor: Colors.lightBlueAccent,
                                      icon: Icon(
                                        Icons.list,
                                        color: FlutterFlowTheme.tertiaryColor,
                                        size: 20,
                                      ),
                                      onPressed: () async {
                                        await showDialog(
                                          context: context,
                                          builder: (alertDialogContext) {
                                            BlocProvider.of<GetTextBloc>(
                                                    context)
                                                .add(GetTextBlocRefreshEvent());
                                            BlocProvider.of<GetTextBloc>(
                                                    context)
                                                .add(GetTextBlocGetEvent(
                                                    item_id: item.id));
                                            return AlertDialog(
                                                title: Text(item.description),
                                                content: SizedBox(
                                                  height: 400,
                                                  child: Container(
                                                    width: double.maxFinite,
                                                    child: BlocBuilder<
                                                            GetTextBloc,
                                                            GetTextBlocState>(
                                                        builder:
                                                            (context, state) {
                                                      if (state
                                                          is GetTextBlocStateLoading)
                                                        return Center(
                                                            child:
                                                                CircularProgressIndicator());
                                                      else {
                                                        final texts = (state
                                                                as GetTextBlocStateLoaded)
                                                            .texts;
                                                        if (texts.isNotEmpty) {
                                                          return ListView
                                                              .builder(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .zero,
                                                                  itemCount: texts
                                                                      .length,
                                                                  itemBuilder:
                                                                      (context,
                                                                          index) {
                                                                    final text =
                                                                        texts[
                                                                            index];

                                                                    return Padding(
                                                                      padding: EdgeInsetsDirectional
                                                                          .fromSTEB(
                                                                              7,
                                                                              30,
                                                                              7,
                                                                              0),
                                                                      child:
                                                                          FFButtonWidget(
                                                                        onPressed:
                                                                            () async {
                                                                          item.value = text
                                                                              .description
                                                                              .toString();
                                                                          item.working =
                                                                              '0';
                                                                          Navigator.pop(
                                                                              context);
                                                                         dynamic response = await  recordValue(
                                                                              item);
                                                                        },
                                                                        text: text
                                                                            .description,
                                                                        options:
                                                                            FFButtonOptions(
                                                                          width:
                                                                              double.infinity,
                                                                          height:
                                                                              40,
                                                                          color:
                                                                              Colors.white,
                                                                          textStyle: FlutterFlowTheme
                                                                              .subtitle2
                                                                              .override(
                                                                            fontFamily:
                                                                                'Open Sans',
                                                                            color:
                                                                                Color(0xFF2CA4D4),
                                                                            fontSize:
                                                                                20,
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                          ),
                                                                          borderSide:
                                                                              BorderSide(
                                                                            color:
                                                                                Color(0xFF2CA4D4),
                                                                            width:
                                                                                3,
                                                                          ),
                                                                          borderRadius:
                                                                              15,
                                                                        ),
                                                                      ),
                                                                    );
                                                                  });
                                                        } else {
                                                          return Container(
                                                            child: Center(
                                                              child: Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .min,
                                                                children: [
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                            .all(
                                                                        10.0),
                                                                    child: Icon(
                                                                      FontAwesomeIcons
                                                                          .folderOpen,
                                                                      color:
                                                                          firstColor,
                                                                      size: 50,
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                            .all(
                                                                        10.0),
                                                                    child:
                                                                        AutoSizeText(
                                                                      'NESSUN ELEMENTO',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      maxLines:
                                                                          1,
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            30,
                                                                        fontWeight:
                                                                            FontWeight.bold,
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
                                                ));
                                          },
                                        );
                                      },
                                    );
                                    break;
                                  case T_WORK:
                                    icon = Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Checkbox(
                                            value: item.value == 'true',
                                            activeColor: Colors.blue,
                                            onChanged: (bool? value) {
                                              setState(() {
                                                bool ActualValue =
                                                    item.value == 'true';
                                                ActualValue = !ActualValue;
                                                item.value = ActualValue
                                                    ? 'true'
                                                    : 'false';
                                                item.working =
                                                    !ActualValue ? '0' : '0';
                                              });
                                              recordValue(item);
                                            }),
                                        if (item.value == 'true')
                                          Row(children: [
                                            Text('Non Funziona'),
                                            Checkbox(
                                                value: item.working == '1',
                                                activeColor: Colors.red,
                                                onChanged: (bool? value) async {
                                                  setState(() {
                                                    bool ActualValue =
                                                        item.working == '1';
                                                    ActualValue = !ActualValue;
                                                    item.working =
                                                        ActualValue ? '1' : '0';
                                                  });
                                                dynamic response = await   recordValue(item);
                                                })
                                          ])
                                      ],
                                    );
                                    break;
                                }
                                return Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                          color: Colors.lightBlueAccent),
                                    ),
                                  ),
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 5, 0, 5),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      AutoSizeText(
                                        item.description,
                                        maxLines: 1,
                                        style:
                                            FlutterFlowTheme.subtitle2.override(
                                          fontFamily: 'Open Sans',
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Row(children: [
                                        icon,
                                      ]),
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
                ),
                Align(
                  alignment: AlignmentDirectional(0, 1),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
                          child: FlutterFlowIconButton(
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
                             Navigator.pushNamed(context, SectionWidget.ROUTE_NAME, arguments: SectionWidgetArg(
                                                    user: user,
                                                    checklist_id: section.checklist_id,
                                                    selectedVehicle:  selectedVehicle));
                            },                     
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
                          child: FFButtonWidget(
                            onPressed: () async {
                              check(section.id);
                            },
                            text: 'Controlla',
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
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
