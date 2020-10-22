import 'package:flutter/material.dart';

import 'widgets/mainButtonBar.dart';
import 'widgets/topBubble.dart';
import 'widgets/bottomBubble.dart';

//TESTING
// import 'routes/qr-generate.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flirt',
      home: _HomePageState(),
      theme: ThemeData(
        fontFamily: "Nunito",
        textTheme: ThemeData.light().textTheme.copyWith(
              headline4: TextStyle(
                fontFamily: 'Nunito',
                fontWeight: FontWeight.bold,
                fontSize: 50,
                color: Colors.black,
              ),
              bodyText1: TextStyle(
                fontFamily: 'Nunito',
                fontSize: 18,
                color: Colors.white,
              ),
            ),
        primaryColor: Color(0xFF347be0),
        accentColor: Color(0xFF004e92),
      ),
    );
  }
}

class _HomePageState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          TopBubble(),
          MainButtonBar(),
          BottomBubble(),
          // FOR TESTING ONLY DON'T REMOVE
          // Positioned(
          //   bottom: 0,
          //   child: FlatButton.icon(
          //     icon: Icon(Icons.select_all),
          //     label: Text(
          //       'GENERATE',
          //       style: Theme.of(context)
          //           .textTheme
          //           .bodyText1
          //           .copyWith(fontSize: 20),
          //     ),
          //     onPressed: () {
          //       Navigator.push(
          //         context,
          //         MaterialPageRoute(builder: (context) => QRGenerate()),
          //       );
          //     },
          //     padding:
          //         EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
          //     color: Colors.transparent,
          //   ),
          // ),
        ],
      ),
    );
  }
}
