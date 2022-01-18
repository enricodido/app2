import 'package:flutter/material.dart';

class FlutterFlowIconButton extends StatelessWidget {
  const FlutterFlowIconButton({
    this.borderColor,
    this.borderRadius,
    this.borderWidth,
    required this.buttonSize,
    required this.fillColor,
    required this.icon,
    required this.onPressed
  });

  final double? borderRadius;
  final double buttonSize;
  final Color fillColor;
  final Color? borderColor;
  final double? borderWidth;
  final Widget icon;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) => Material(
    borderRadius: BorderRadius.circular(borderRadius!),
    color: Colors.transparent,
    clipBehavior: Clip.antiAlias,
    child: Ink(
      width: buttonSize,
      height: buttonSize,
      decoration: BoxDecoration(
        color: fillColor,
        border: Border.all(
          color: borderColor ?? Colors.transparent,
          width: borderWidth ?? 0,
        ),
        borderRadius: BorderRadius.circular(borderRadius!),
      ),
      child: IconButton(
        icon: icon,
        onPressed: onPressed,
        splashRadius: buttonSize,
      ),
    ),
  );
}
