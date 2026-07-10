import 'package:flirt/configs/themes.dart';
import 'package:flirt/core/domain/live_activities_service.dart';
import 'package:flirt/core/infrastructures/repository/quote_repository.dart';
import 'package:flirt/core/infrastructures/repository/settings_repository.dart';
import 'package:flirt/core/module/home/application/service/cubit/home_cubit.dart';
import 'package:flirt/core/module/home/interfaces/screens/home_screen.dart';
import 'package:flirt/core/module/live_activity/application/service/cubit/live_activity_cubit.dart';
import 'package:flirt/core/module/settings/interfaces/widgets/force_upgrade_dialog.dart';
import 'package:flirt/core/module/settings/service/settings_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  /// Load env file
  await dotenv.load();

  // Initialize LiveActivitiesService early so native plugins are ready
  try {
    await LiveActivitiesService.instance.init();
    await LiveActivitiesService.instance.start();
  } catch (_) {
    // ignore errors during init so app still launches
  }

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: <BlocProvider<dynamic>>[
        BlocProvider<HomeCubit>(
          create: (BuildContext context) =>
              HomeCubit(quoteRepository: QuoteRepository()),
        ),
        BlocProvider<LiveActivityCubit>(
          create: (BuildContext context) =>
              LiveActivityCubit(quoteRepository: QuoteRepository()),
        ),
        BlocProvider<SettingsCubit>(
          create: (BuildContext context) =>
              SettingsCubit(settingsRepository: SettingsRepository()),
        ),
      ],
      child: MaterialApp(
        home: _HomePageState(),
        theme: defaultTheme,
        supportedLocales: const <Locale>[Locale('en')],
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class _HomePageState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ForceUpgradeDialog(
      onValidate: () {
        // context.read<OnboardingCubit>().getCurrentUser(fromValidateToken: true);
      },
      child: const HomeScreen(),
    );
  }
}
