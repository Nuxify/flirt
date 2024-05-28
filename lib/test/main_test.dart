// ignore_for_file: depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> loadAllDependencies() async {
  TestWidgetsFlutterBinding.ensureInitialized();

  await dotenv.load();
}

Widget universalPumper(
  Widget child, {
  NavigatorObserver? observer,
  Locale? locale,
}) {
  return Builder(
    builder: (BuildContext context) {
      return MaterialApp(
        home: child,
        navigatorObservers: observer != null
            ? <NavigatorObserver>[observer]
            : <NavigatorObserver>[],
      );
    },
  );
}

Widget universalPumperWithRouteArguement(
  Widget child, {
  NavigatorObserver? observer,
  Object? arguements,
}) {
  return Builder(
    builder: (BuildContext context) {
      return MaterialApp(
        navigatorObservers: observer != null
            ? <NavigatorObserver>[observer]
            : <NavigatorObserver>[],
        onGenerateRoute: (RouteSettings settings) {
          return MaterialPageRoute<dynamic>(
            settings: RouteSettings(
              arguments: arguements,
            ),
            builder: (_) => child,
          );
        },
      );
    },
  );
}
