import 'package:checklist/page/auth/login.dart';
import 'package:checklist/repositories/repository.dart';
import 'package:checklist/page/selectModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:checklist/page/home.dart';
import 'package:intl/date_symbol_data_local.dart';

final getIt = GetIt.instance;
void main() {
  getIt.registerSingleton(Repository());
  initializeDateFormatting().then((_) => runApp(
    App(),
  ));
}


class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: LoginPage.ROUTE_NAME,
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
          unselectedLabelStyle: GoogleFonts.montserrat(),
        ),
      ),
      routes: {
        HomePage.ROUTE_NAME: (_) => HomePage(),
        LoginPage.ROUTE_NAME: (_) => LoginPage(),
        SchedaControlliSceltaWidget.ROUTE_NAME: (_) => SchedaControlliSceltaWidget(),
      },
    );
  }
}