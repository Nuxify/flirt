import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:Flirt/configs/themes.dart';
import 'package:Flirt/routes.dart';

import 'package:Flirt/module/record/service/cubit/record_cubit.dart';

import 'package:Flirt/interfaces/screens/home_screen.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: <BlocProvider<dynamic>>[
        // ================ record module ================
        BlocProvider<RecordCubit>(
          create: (BuildContext context) => RecordCubit(),
        ),
      ],
      child: MaterialApp(
        title: 'Flirt',
        home: _HomePageState(),
        theme: defaultTheme,
        supportedLocales: const <Locale>[
          Locale('en'),
        ],
        routes: routes,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class _HomePageState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const HomeScreen();
  }
}
