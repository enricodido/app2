import 'package:checklist/repositories/repository.dart';
import 'package:checklist/theme/color.dart';
import 'package:flutter/scheduler.dart';

import 'package:flutter/material.dart';

import '../main.dart';
import 'auth/login.dart';
import 'homePage/home.dart';

class SplashPageWidget extends StatefulWidget {
  static const ROUTE_NAME = '/splash';

  @override
  _SplashPageWidgetState createState() => _SplashPageWidgetState();
}

class _SplashPageWidgetState extends State<SplashPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance!.addPostFrameCallback((_) async {

      await getIt.get<Repository>().sessionRepository!.init();
      bool isUserLogged = getIt.get<Repository>().sessionRepository!.isLogged();
      await Future.delayed(Duration(seconds: 2));

      if (isUserLogged) {
        await getIt
            .get<Repository>()
            .userRepository!
            .refresh();
        await Navigator.popAndPushNamed(context, HomePageWidget.ROUTE_NAME);
      } else {
        await Navigator.popAndPushNamed(context, LoginPageWidget.ROUTE_NAME);
        print('errore');
      }




    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xFFF5F5F5),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xFFEEEEEE),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: Image.asset(
              'assets/images/GBM-app-background-complete.png',
            ).image,
          ),
        ),
        child: Align(
          alignment: AlignmentDirectional(0, 0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(

                child: CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(firstColor),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
