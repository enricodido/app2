// ignore_for_file: unnecessary_this

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  CustomFormField({
    required this.label,
    required this.icon,
    this.keyboard = TextInputType.text,
    this.obscure = false,
    required this.controller,
    required this.error,
    this.require = true,
    this.placeholder,
    this.onchange,
  });

  final String label;
  final IconData icon;
  final TextInputType keyboard;
  final bool obscure;
  final TextEditingController controller;
  final String error;
  final bool require;
  final String? placeholder;
  final Function()? onchange;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
              child: Text(
                this.label,
                textAlign: TextAlign.center,
              )),
          const SizedBox(
            height: 10,
          ),
          Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            semanticContainer: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            color: Colors.grey.withOpacity(0.3),
            elevation: 0,
            child: CupertinoTextFormFieldRow(
              onEditingComplete: onchange,
              placeholder: placeholder,
              validator: (value) {
                if (require) {
                  if (value!.isEmpty) {
                    return error;
                  }
                  return null;
                }
                return null;
              },
              controller: controller,
              keyboardType: this.keyboard,
              obscureText: this.obscure,
            ),
          ),
        ],
      ),
    );
  }
}
