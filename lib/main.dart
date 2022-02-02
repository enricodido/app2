import 'package:checklist/page/checklistOpen/checklistOpen.dart';
import 'package:checklist/page/items/item.dart';
import 'package:checklist/page/section/section.dart';
import 'package:checklist/page/auth/login.dart';
import 'package:checklist/page/splash.dart';
import 'package:checklist/page/userPage/user_page_widget.dart';
import 'package:checklist/repositories/repository.dart';
import 'package:checklist/page/selectModel/selectModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:checklist/page/homePage/home.dart';

import 'blocs/get_checklist.dart';
import 'blocs/get_item.dart';
import 'blocs/get_model.dart';
import 'blocs/get_section.dart';
import 'blocs/get_text.dart';
import 'blocs/time.dart';
import 'blocs/user_me.dart';

final getIt = GetIt.instance;

const String STATUS_OPEN = '0';
const String STATUS_ASSIGNED = '1';
const String STATUS_CLOSED = '2';

const String T_NUMBER = '1';
const String T_TEXT = '2';
const String T_LIST = '3';
const String T_BOOL = '4';
const String T_WORK = '5';

void main() {
  getIt.registerSingleton(Repository());
  runApp(
    MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => UserMeBloc(
                    UserMeBlocStateLoading()
                ),
          ),
          BlocProvider(
            create: (_) => TimeSlotBloc(
                    TimeSlotBlocStateLoading()
                ),
          ),
          BlocProvider(
            create: (_) => GetModelBloc(
                    GetModelBlocStateLoading()
                ),
          ),
          BlocProvider(
            create: (_) =>
                GetChecklistBloc(
                    GetChecklistBlocStateLoading()
                ),
          ),
          BlocProvider(
            create: (_) =>
                GetSectionBloc(
                    GetSectionBlocStateLoading()
                ),
          ),
          BlocProvider(
            create: (_) =>
                GetItemBloc(
                    GetItemBlocStateLoading()
                ),
          ),
          BlocProvider(
            create: (_) =>
                GetTextBloc(
                    GetTextBlocStateLoading()
                ),
          ),
        ],
        child: MyApp(),
  ),);
}



class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Deltacall Checklist',
      debugShowCheckedModeBanner: false,
      initialRoute: LoginPageWidget.ROUTE_NAME,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.lightBlueAccent,
        textTheme: GoogleFonts.montserratTextTheme(),
        primaryTextTheme: GoogleFonts.montserratTextTheme(),
        accentTextTheme: GoogleFonts.montserratTextTheme(),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.lightBlueAccent,
        ),
        primaryColor: Colors.lightBlueAccent,
        tabBarTheme: TabBarTheme(
          labelStyle: GoogleFonts.montserrat(
              textStyle: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              )),

        ),
      ),
      routes: {
        LoginPageWidget.ROUTE_NAME: (_) => LoginPageWidget(),
        HomePageWidget.ROUTE_NAME: (_) => HomePageWidget(),
        SchedaControlliSceltaWidget.ROUTE_NAME: (_) => SchedaControlliSceltaWidget(),
        UserPageWidget.ROUTE_NAME: (_) => UserPageWidget(),
        SplashPageWidget.ROUTE_NAME: (_) => SplashPageWidget(),
        SectionWidget.ROUTE_NAME: (_) => SectionWidget(),
        ItemWidget.ROUTE_NAME: (_) => ItemWidget(),
        ChecklistAperteWidget.ROUTE_NAME: (_) => ChecklistAperteWidget(),
      },
    );
  }
}
