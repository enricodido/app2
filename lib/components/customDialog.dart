import 'package:checklist/theme/color.dart';
import 'package:flutter/material.dart';

void showCustomDialog({
  required BuildContext context,
  String? title,
  required int type,
  required String msg,
}) {
  Widget alert;

  switch (type) {
    case CustomDialog.ERROR:
      alert = CustomDialog.error(
        message: msg,
      );
      break;

    case CustomDialog.WARNING:
      alert = CustomDialog.warning(
        message: msg,
      );
      break;

    case CustomDialog.SUCCESS:
      alert = CustomDialog.success(
        message: msg,
      );
      break;
    case CustomDialog.INFO:
      alert = CustomDialog.info(
        message: msg,
        headerTitle: title,
      );
      break;

    default:
      alert = CustomDialog.error(
        message: msg,
      );
      break;
  }
  showDialog(
      context: context,
      builder: (context) {
        return alert;
      });
}

class CustomDialog extends StatelessWidget {
  static const ERROR = 0;
  static const WARNING = 1;
  static const INFO = 2;
  static const SUCCESS = 3;

  CustomDialog({
    required this.title,
    required this.color,
    required this.msg,
  });

  final String title;
  final Color color;
  final String msg;

  factory CustomDialog.error({
    required String message,
  }) {
    return CustomDialog(
      title: 'ERRORE',
      color: Colors.red,
      msg: message,
    );
  }

  factory CustomDialog.warning({
    required String message,
  }) {
    return CustomDialog(
      title: 'ATTENZIONE',
      color: Colors.orange,
      msg: message,
    );
  }

  factory CustomDialog.info({
    required String message,
    String? headerTitle,
  }) {
    return CustomDialog(
      title: headerTitle ?? 'Info',
      color: firstColor,
      msg: message,
    );
  }
  factory CustomDialog.success({
    required String message,
    String? headerTitle,
  }) {
    return CustomDialog(
        title: 'Successo',
        color: Colors.green,
        msg: message
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: double.infinity,
              // color: color,
              child: Text(title,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: color)),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              msg,
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 16,
            ),
            MaterialButton(
              onPressed: () {
                Navigator.pop(context);
              },
              color:  Colors.green,
              minWidth: double.infinity,
              height: 40,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              textColor: secondColor,
              child: Text("OK"),
            )
          ],
        ),
      ),
    );
  }
}
