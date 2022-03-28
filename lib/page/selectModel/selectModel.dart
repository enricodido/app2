import 'package:auto_size_text/auto_size_text.dart';
import 'package:checklist/blocs/get_model.dart';
import 'package:checklist/components/customDialog.dart';
import 'package:checklist/components/flutter_flow_theme.dart';
import 'package:checklist/components/flutter_flow_widget.dart';
import 'package:checklist/model/selectModel.dart';
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

class _SchedaControlliSceltaWidgetState
    extends State<SchedaControlliSceltaWidget> {

  final scaffoldKey = GlobalKey<ScaffoldState>();

  UserModel? user;
  SelectModel? selectModel;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();


      SchedulerBinding.instance!.addPostFrameCallback((_) async {
        setState(() {
        final args = ModalRoute.of(context)!.settings.arguments as SchedaControlliSceltaWidgetArg;
        user = args.user;

      });
        BlocProvider.of<GetModelBloc>(context).add(GetModelBlocRefreshEvent());
        BlocProvider.of<GetModelBloc>(context).add(GetModelBlocGetEvent());
    });
  }
  void logout(BuildContext context) {
    getIt.get<Repository>().sessionRepository!.logout();
    Navigator.pushNamedAndRemoveUntil(
        context, LoginPageWidget.ROUTE_NAME, ModalRoute.withName('/'));
  }

  void clickModel(SelectModel model, UserModel user) async {
    final  result = await
    getIt.get<Repository>().checklistModelRepository!.create(context,  user.id.toString(), model.id.toString());
    if(result != null) {
      Navigator.pushNamed(context, SectionWidget.ROUTE_NAME,
          arguments: SectionWidgetArg(user: user, checklist_id: result, selectedVehicle: 'Seleziona Mezzo')
         
      );
       
      setState(() {
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      showCustomDialog(
        context: context,
        type: CustomDialog.WARNING,
        msg:'Errore!',
      );
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.black,
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
                  margin: const EdgeInsets.only(top: 20.0),
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
                                                              child: ElevatedButton(
                                                                onPressed: () {
                                                                 
                                                                  Navigator.pop(context) ;                                                                                                                                                                                                           
                                                                },
                                                                style: ElevatedButton
                                                                    .styleFrom(
                                                                  primary: Colors
                                                                      .red,
                                                                  // fixedSize: Size(250, 50),
                                                                ),
                                                                child:
                                                                    TextButton(
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
                                                            ),
                                                            Container(
                                                              width: double
                                                                  .infinity,
                                                              height: 60,
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                    
                                                                child:ElevatedButton(
                                                                onPressed: () {
                                                                 
                                                                  Navigator.pop(context) ;                                                                                                                                                                                                           
                                                                },
                                                                style: ElevatedButton
                                                                    .styleFrom(
                                                                  primary: Colors
                                                                      .blue,
                                                                  // fixedSize: Size(250, 50),
                                                                ),
                                                                child:
                                                                    TextButton(
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
                                                              ),
                                                              ])
                                                            
                                                            ]),
                                          )));
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
              'Seleziona la scheda da controllare',
              style: FlutterFlowTheme.bodyText1.override(
                fontFamily: 'Open Sans',
                color: Color(0xFFBDBDBD),
                fontSize: 18,
              ),
            ),
            Expanded(
             // width: MediaQuery.of(context).size.width,
             // margin: EdgeInsets.only(left: 15.0, right: 15.0),
              child: BlocBuilder<GetModelBloc, GetModelBlocState>(
                  builder: (context, state) {
                    if (state is GetModelBlocStateLoading)
                      return Center(child: CircularProgressIndicator());
                     else {
                      final models = (state as GetModelBlocStateLoaded).models;
                      if(models.isNotEmpty) {
                        return ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: models.length,
                            itemBuilder: (context, index) {

                              final model = models[index];

                              return Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(7, 30, 7, 0),
                                  child: FFButtonWidget(
                                    onPressed: ()  {
                                      clickModel(model, user!);
                                    },
                                    text: model.description,
                                    options: FFButtonOptions(
                                      width: double.infinity,
                                      height: 120,
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

          ],
        ),
      ),
    );
  }
}
