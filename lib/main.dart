import 'package:flirt/configs/themes.dart';
import 'package:flirt/infrastructures/repository/quote_repository.dart';
import 'package:flirt/module/home/interfaces/screens/home_screen.dart';
import 'package:flirt/module/home/service/cubit/quote_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  /// Load env file
  await dotenv.load();

  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: <BlocProvider<dynamic>>[
        // ================ quote module ================
        BlocProvider<QuoteCubit>(
          create: (BuildContext context) => QuoteCubit(
            quoteRepository: QuoteRepository(),
          ),
        ),
      ],
      child: MaterialApp(
        title: dotenv.get('TITLE'),
        home: _HomePageState(),
        theme: defaultTheme,
        supportedLocales: const <Locale>[
          Locale('en'),
        ],
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
