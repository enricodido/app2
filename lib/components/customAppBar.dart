import 'package:checklist/theme/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  CustomAppBar({
    this.bottom,
    this.leading,
    this.title,
  });

  final PreferredSizeWidget? bottom;
  final Widget? leading;
  final String? title;

  factory CustomAppBar.back(
      BuildContext context,
      String title,
      ) {
    final Widget leading = Padding(
      padding: const EdgeInsets.all(5.0),
      child: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(
          CupertinoIcons.back,
          color: secondColor,
        ),
      ),
    );

    return CustomAppBar(
      bottom: null,
      leading: leading,
      title: title,
    );
  }

  factory CustomAppBar.backWithoutLogo(
      BuildContext context,
      String title,
      ) {
    final Widget leading = Padding(
      padding: const EdgeInsets.all(5.0),
      child: FloatingActionButton(
        backgroundColor: secondColor,
        heroTag: 'back',
        onPressed: () {
          Navigator.pop(context);
        },
        child: Icon(
          CupertinoIcons.back,
          color: firstColor,
        ),
      ),
    );

    return CustomAppBar(
      bottom: null,
      leading: leading,
      title: title,
    );
  }

  factory CustomAppBar.withoutLogo(
      BuildContext context,
      ) {
    return CustomAppBar(
      bottom: null,
      leading: null,
      title: '',
    );
  }

  @override
  Widget build(BuildContext context) {
    return customAppBar(context);
  }

  Widget customAppBar(BuildContext context) => SliverAppBar(
    floating: true,
    snap: true,
    centerTitle: true,
    backgroundColor: firstColor,
    brightness: Brightness.light, // Brightness.dark,
    leading: leading ?? Container(),
    title: (title != null)
        ? Text(
      title!,
      style: TextStyle(
        color: secondColor,
        fontSize: 35,
        fontWeight: FontWeight.bold,
      ),
    )
        : Container(),
    bottom: bottom,
  );
}
