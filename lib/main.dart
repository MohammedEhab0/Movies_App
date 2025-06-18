import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'UI/Di/di.dart';
import 'utils/my_BlocObserver.dart';
import 'utils/app_theme.dart';

import 'Providers/SettingProvider.dart';
import 'Providers/UserProvider.dart';

import 'UI/auth/login/Login.dart';
import 'UI/auth/register/Register.dart';
import 'UI/homescreen/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();

  await configureDependencies(); // Set up dependency injection

  final userProvider = UserProvider();
  await userProvider.loadUserFromPrefs(); // Load saved user info

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      startLocale: const Locale('en'),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => SettingProviders()),
          ChangeNotifierProvider<UserProvider>.value(value: userProvider),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final isLoggedIn = context.watch<UserProvider>().isLoggedIn;

    return MaterialApp(
      title: 'Movies',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      initialRoute: isLoggedIn ? HomeScreen.routeName : Register.routeName,
      routes: {
        Login.routeName: (_) => const Login(),
        Register.routeName: (_) => const Register(),
        HomeScreen.routeName: (_) => const HomeScreen(),
      },
    );
  }
}