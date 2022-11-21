import 'package:flutter/material.dart';

class QuoteFloatingButton extends StatelessWidget {
  const QuoteFloatingButton({required this.controller, Key? key})
      : super(key: key);
  final ScrollController controller;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Card(
      shape: const CircleBorder(),
      color: theme.primaryColor.withAlpha(240),
      child: IconButton(
        onPressed: () {
          controller.animateTo(
            controller.position.maxScrollExtent,
            duration: const Duration(seconds: 2),
            curve: Curves.fastOutSlowIn,
          );
        },
        icon: const Icon(
          Icons.arrow_downward_sharp,
          color: Colors.white,
        ),
      ),
    );
  }
}
