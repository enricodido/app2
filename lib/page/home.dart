
import 'package:checklist/components/customAppBar.dart';
import 'package:checklist/model/user.dart';
import 'package:checklist/repositories/repository.dart';
import 'package:checklist/theme/color.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import 'auth/login.dart';

class HomePage extends StatefulWidget {
  static const ROUTE_NAME = '/home';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  void logout() async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    child: Text('Logout',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            color: firstColor)),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Confermi di voler eseguire il logout?",
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  MaterialButton(
                    onPressed: () {
                      Navigator.pop(context, false);
                    },
                    color: Colors.transparent,
                    elevation: 0.0,
                    minWidth: double.infinity,
                    height: 40,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    textColor: Colors.black,
                    child: Text("Annulla"),
                  ),
                  MaterialButton(
                    onPressed: () {
                      Navigator.pop(context, true);
                    },
                    color: firstColor,
                    minWidth: double.infinity,
                    height: 40,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    textColor: secondColor,
                    child: Text("Conferma"),
                  )
                ],
              ),
            ),
          );
        }).then((value) {
      if (value != null) {
        if (value) {
          getIt.get<Repository>().sessionRepository!.logout();
          Navigator.pushNamedAndRemoveUntil(
            context,
            LoginPage.ROUTE_NAME,
            ModalRoute.withName('/'),
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondColor,
      body: CustomScrollView(slivers: <Widget>[
        CustomAppBar(
          title: 'ChecklistApp',
          leading: IconButton(
              onPressed: () {
                logout();
              },
              icon: Icon(
                Icons.logout_rounded,
                color: secondColor,
              )),
        ),
        user(context),
      ]),
    );
  }

  Widget user(BuildContext context) {
    return FutureBuilder<UserModel>(
        future: getIt.get<Repository>().userRepository!.me(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return SliverPadding(
              padding: EdgeInsets.zero,
              sliver: SliverToBoxAdapter(
                child: Card(
                    margin: const EdgeInsets.all(10.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                        side: BorderSide(color: firstColor, width: 1.0)),
                    elevation: 3,
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    color: secondColor,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 20.0),
                      child: ListTile(
                        title: Text(
                          snapshot.data!.username,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 25),
                        ),
                        subtitle: Text(
                          snapshot.data!.fullname,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        leading: Icon(Icons.work_outlined,
                            size: 50.0, color: Colors.black),
                      ),
                    )),
              ),
            );
          } else {
            return SliverPadding(
              padding: EdgeInsets.all(20.0),
              sliver: SliverToBoxAdapter(
                child: Container(
                  child: Center(
                      child: CircularProgressIndicator(
                        valueColor: new AlwaysStoppedAnimation<Color>(secondColor),
                      )),
                ),
              ),
            );
          }
        });
  }
}

