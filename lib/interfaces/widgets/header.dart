import 'package:flutter/material.dart';

class Header extends StatelessWidget with PreferredSizeWidget {
  const Header({required this.title, Key? key}) : super(key: key);

  final String title;

  @override
  Size get preferredSize => const Size.fromHeight(55);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(15),
          bottomRight: Radius.circular(15),
        ),
      ),
      backgroundColor: Theme.of(context).primaryColor,
    );
  }
}
