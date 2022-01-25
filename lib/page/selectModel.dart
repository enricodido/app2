import 'dart:async';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:checklist/blocs/get_checklist.dart';
import 'package:checklist/blocs/get_model.dart';
import 'package:checklist/blocs/user_me.dart';
import 'package:checklist/components/flutter_flow_theme.dart';
import 'package:checklist/components/flutter_flow_widget.dart';
import 'package:checklist/model/selectModel.dart';
import 'package:checklist/model/user.dart';
import 'package:checklist/page/auth/login.dart';
import 'package:checklist/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'ambulanceModel.dart';
import 'home.dart';
import 'nurseModel.dart';

class SchedaControlliSceltaWidgetArg {
  SchedaControlliSceltaWidgetArg({
    required this.user,
  });

  final UserModel? user;
}

class SchedaControlliSceltaWidget extends StatefulWidget {
  static const ROUTE_NAME = '/selectModel';

  @override
  _SchedaControlliSceltaWidgetState createState() =>
      _SchedaControlliSceltaWidgetState();
}

class _SchedaControlliSceltaWidgetState extends State<SchedaControlliSceltaWidget> {

  bool isLoading = false;
  TextEditingController textFieldCausalController = TextEditingController();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  UserModel? user;
  
  @override
  void initState() {

    super.initState();


    SchedulerBinding.instance!.addPostFrameCallback((_) async {
      final args = ModalRoute.of(context)!.settings.arguments as SchedaControlliSceltaWidgetArg;
      user = args.user;
     
    });

  }
  SelectModel? selectedModel;

  void dialogCausal() {
    selectedModel = null;
    textFieldCausalController.clear();

    BlocProvider.of<GetModelBloc>(context).add(GetModelBlocRefreshEvent());
    BlocProvider.of<GetModelBloc>(context).add(
        GetModelBlocGetEvent(status: '1'));

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return Dialog(
            insetPadding: EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 20.0,
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5)),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.07,
                  child: Center(
                    child: AutoSizeText(
                      'Lista Causali',
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 30
                      ),
                    ),
                  ),
                ),
                Expanded(
                    child: Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      margin: EdgeInsets.only(left: 15.0, right: 15.0),
                      child: BlocBuilder<GetModelBloc, GetModelBlocState>(
                          builder: (context, state) {
                            if (state is GetModelBlocStateLoading)
                              return Center(child: CircularProgressIndicator());
                            else {
                              final models = (state as GetModelBlocStateLoaded)
                                  .models;
                              if (models.length > 0) {
                                return ListView.builder(
                                    padding: EdgeInsets.zero,
                                    itemCount: models.length,
                                    itemBuilder: (context, index) {
                                      final model = models[index];

                                      return GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              selectedModel = model;
                                              textFieldCausalController.text =
                                                  selectedModel!.description;
                                              Navigator.pop(context);
                                            });
                                          },
                                          child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .only(top: 5.0, bottom: 5.0),
                                              child: Material(
                                                color: Colors.transparent,
                                                elevation: 2,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius
                                                      .circular(15),
                                                ),
                                                child: Container(
                                                  width: MediaQuery
                                                      .of(context)
                                                      .size
                                                      .width * 0.9,
                                                  height: 60,
                                                  decoration: BoxDecoration(
                                                    color: Color(0xFFDBDBDB),
                                                    borderRadius: BorderRadius
                                                        .circular(15),
                                                  ),
                                                  child: Container(
                                                    width: MediaQuery
                                                        .of(context)
                                                        .size
                                                        .width * 1,
                                                    height: double.infinity,
                                                    decoration: BoxDecoration(
                                                      color: Color(0x00EEEEEE),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                      EdgeInsetsDirectional
                                                          .fromSTEB(
                                                          10, 0, 0, 0),
                                                      child: Column(
                                                        mainAxisSize: MainAxisSize
                                                            .max,
                                                        mainAxisAlignment: MainAxisAlignment
                                                            .center,
                                                        crossAxisAlignment: CrossAxisAlignment
                                                            .start,
                                                        children: [
                                                          AutoSizeText(
                                                            model.description,
                                                            maxLines: 1,
                                                            style: FlutterFlowTheme
                                                                .bodyText1
                                                                .override(
                                                              fontFamily: 'Poppins',
                                                              fontSize: 24,
                                                              fontWeight: FontWeight
                                                                  .w600,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )
                                          )
                                      );
                                    }
                                );
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
                    )
                ),
              ],
            ),
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
  }