import 'dart:io';

import 'package:cafe_mostbyte/screen/auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:window_manager/window_manager.dart';
import '/bloc/auth/authentificate.dart/authentification_bloc.dart';
import '/bloc/auth/authentificate.dart/authentification_state.dart';
import '/screen/splash_screen.dart';
import '/services/api_provider/user/user_repository.dart';
import './config/app_language.dart';
import './config/theme.dart';
import './generated/loc_delegate.dart';
import './screen/home_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import './config/globals.dart' as globals;
import 'bloc/auth/authentificate.dart/authentificate_event.dart';

class MyHttpOerrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  HttpOverrides.global = MyHttpOerrides();
  AppLanguage appLanguage = AppLanguage();
  WidgetsFlutterBinding.ensureInitialized();
  // Must add this line.
  await windowManager.ensureInitialized();

  // Use it only after calling `hiddenWindowAtLaunch`
  windowManager.waitUntilReadyToShow().then((_) async {
    windowManager.setFullScreen(true);
    windowManager.setClosable(true);
    windowManager.show();
  });
  final prefs = await SharedPreferences.getInstance();
  await appLanguage.fetchLocale(prefs);
  runApp(RepositoryProvider(
      create: (context) => UserRepository(),
      child:
          MyApp(appLanguage: appLanguage, userRepository: UserRepository())));
}

class MyApp extends StatefulWidget {
  final AppLanguage appLanguage;
  final UserRepository userRepository;

  const MyApp(
      {required this.appLanguage, required this.userRepository, Key? key})
      : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppLanguage>(
      create: (_) => widget.appLanguage,
      child: Consumer<AppLanguage>(builder: (context, model, child) {
        return BlocProvider<AuthenticationBloc>(
          create: (context) => AuthenticationBloc(
            userRepository: context.read<UserRepository>(),
          ),
          child: BlocBuilder<AuthenticationBloc, AuthentifacionState>(
              builder: (BuildContext context, AuthentifacionState state) {
            var _page;
            if (state is AuthenticationUninitialized) {
              context.read<AuthenticationBloc>().add(AppStarted());
              _page = SplashScreen();
            } else if (state is AuthenticationAuthenticated) {
              _page = MaterialApp(
                title: 'Mostbyte Cafe',
                theme: basicTheme(),
                themeMode: ThemeMode.light,
                // debugShowMaterialGrid: true,
                debugShowCheckedModeBanner: true,
                localizationsDelegates: const [
                  LocDelegate(),
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                ],
                home: HomePage(),
                //globals.isAuth ? MainPage() : MainAuth(),
              );
            } else {
              _page = MaterialApp(
                title: 'Mostbyte Cafe',
                theme: basicTheme(),
                themeMode: ThemeMode.light,
                // debugShowMaterialGrid: true,
                debugShowCheckedModeBanner: true,
                localizationsDelegates: const [
                  LocDelegate(),
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                ],
                home: Auth(),
                //globals.isAuth ? MainPage() : MainAuth(),
              );
            }
            return AnimatedSwitcher(
              duration: Duration(milliseconds: 300),
              child: _page,
            );
          }),
        );
      }),
    );
  }
}

class MainPage extends StatefulWidget {
  MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return HomePage();
  }
}
