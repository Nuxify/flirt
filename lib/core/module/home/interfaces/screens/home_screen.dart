import 'package:flirt/core/module/home/interfaces/widgets/quotes_card.dart';
import 'package:flirt/gen/assets.gen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Assets.images.nuxifyLogo.image(width: width * 0.3),
                  const QuotesCard(),
                ],
              ),
            ),
            Container(
              width: width,
              padding: const EdgeInsets.all(20),
              child: const Text(
                'v1.4.0',
                style: TextStyle(fontSize: 11, color: Colors.white54),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
