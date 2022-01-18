import 'package:flutter/material.dart';

class CustomButtonPrimary extends StatelessWidget {
  CustomButtonPrimary(
      { required this.content,  required this.pressed, required this.color});

  final Widget content;
  final VoidCallback pressed;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: this.pressed,
      color: Colors.lightBlueAccent,
      minWidth: double.infinity,
      height: 50,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      child: this.content,
    );
  }
}
