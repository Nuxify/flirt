import 'package:flutter/material.dart';

class Header extends StatelessWidget with PreferredSizeWidget {
  final String title;

  Header(this.title);

  @override
  Size get preferredSize => Size.fromHeight(55);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(15),
          bottomRight: Radius.circular(15),
        ),
      ),
      backgroundColor: Theme.of(context).primaryColor,
    );
  }
}
