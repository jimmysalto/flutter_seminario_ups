import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seminario_02/src/providers/preferences.dart';
import 'package:seminario_02/src/providers/user.dart';
import 'package:seminario_02/src/routes/routes.dart';
import 'package:seminario_02/src/utils/globals.dart' as utils;

import 'src/pages/menu/bottom_menu.dart';
import 'src/pages/sliders/sliders.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final _preferences = Preferences();
  await _preferences.initPreferences();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Preferences _preferences = Preferences();
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<User>(
          create: (context) => User(),
        ),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Seminario 02',
          routes: getApplicationRoutes(),
          home: _preferences.token == '' ? SlidersPage() : BottomMenuPage(),
          // initialRoute: 'swipe',
          theme: ThemeData(
            // primaryColor: Colors.indigo,
            // accentColor: Colors.pink,
            primaryColor: utils.primaryColor(),
            accentColor: utils.accentColor(),
          )),
    );
  }
}

/* 

        child: MaterialApp(
          title: 'Taxi App',
          theme: appTheme,
          debugShowCheckedModeBanner: false,
          onGenerateRoute: AppRoute.generateRoute,
          home: SplashScreen(),
        )); */
