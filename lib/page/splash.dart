import 'package:checklist/components/customDialog.dart';
import 'package:checklist/page/auth/login.dart';
import 'package:checklist/page/selectModel.dart';
import 'package:checklist/repositories/repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../main.dart';

class SplashPage extends StatefulWidget {
  static const ROUTE_NAME = '/splash';
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance!.addPostFrameCallback((_) async {
      await getIt.get<Repository>().sessionRepository!.init();
      bool isUserLogged = getIt.get<Repository>().sessionRepository!.isLogged();
      await Future.delayed(Duration(seconds: 3));
      if (isUserLogged) {
        try {
          await getIt.get<Repository>().userRepository!.refresh();
          await Navigator.popAndPushNamed(context, SchedaControlliSceltaWidget.ROUTE_NAME);
        } catch (error) {
          print(error);
          showCustomDialog(
              context: context,
              type: CustomDialog.WARNING,
              msg:
                  'Attenzione sessione scaduta effettuare nuovamente la login!');
          await Navigator.popAndPushNamed(context, LoginPageWidget.ROUTE_NAME);
        }
      } else {
        await Navigator.popAndPushNamed(context, LoginPageWidget.ROUTE_NAME);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(child: wallpaperSplash()),
    );
  }

  Widget wallpaperSplash() => Padding(
        padding: EdgeInsets.all(20.0),
        child: Image.asset(
          'images/logo.png',
          fit: BoxFit.contain,
        ),
      );
}
