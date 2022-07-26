import 'package:flirt/configs/themes.dart';
import 'package:flirt/module/home/interfaces/screens/home_screen.dart';
import 'package:flirt/module/quote/service/cubit/quote_cubit.dart';
import 'package:flirt/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: <BlocProvider<dynamic>>[
        // ================ quote module ================
        BlocProvider<QuoteCubit>(
          create: (BuildContext context) => QuoteCubit(),
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
