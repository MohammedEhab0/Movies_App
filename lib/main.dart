import 'package:copy_movie/ui/homescreen/onboarding/onboarding.dart';
import 'package:copy_movie/utils/my_BlocObserver.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'Providers/SettingProvider.dart';
import 'Providers/UserProvider.dart';
import 'UI/Di/di.dart';
import 'UI/auth/login/Login.dart';
import 'UI/auth/register/Register.dart';
import 'UI/homescreen/home_screen.dart';
import 'utils/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  configureDependencies();

  final userProvider = UserProvider();
  await userProvider.loadUserFromPrefs(); // load token here ✅

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      startLocale: const Locale('en'),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => SettingProviders()),
          ChangeNotifierProvider<UserProvider>.value(value: userProvider), // ✅
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
    var settingProviders = Provider.of<SettingProviders>(context);
    final isLoggedIn = Provider.of<UserProvider>(context).isLoggedIn;

    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      title: 'Movies',
      initialRoute: isLoggedIn ? HomeScreen.routeName : OnBoarding.routeName,
        
    routes: {
        OnBoarding.routeName:(context)=>OnBoarding(),
        Login.routeName: (context) => const Login(),
        Register.routeName: (context) => const Register(),
        HomeScreen.routeName: (context) => const HomeScreen(),
      },
    );
  }
}
