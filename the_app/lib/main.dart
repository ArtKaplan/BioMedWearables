import 'package:flutter/material.dart';
import 'package:the_app/provider/data_provider.dart';
import 'package:the_app/provider/settings_provider.dart';
import 'package:the_app/provider/stepsProvider.dart';
import 'package:the_app/screens/homePage.dart';
import 'package:the_app/screens/loginPage.dart';
import 'package:the_app/screens/sessionExpiredPage.dart';
import 'package:the_app/screens/steps_test_page.dart';
import 'package:the_app/utils/loginStatus.dart';
import 'package:provider/provider.dart';
import 'package:the_app/theme/app_theme.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => DataProvider()),
        ChangeNotifierProvider(create: (context) => SettingsProvider()),
        ChangeNotifierProvider(create: (context) => StepsProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return MaterialApp(
          theme:
              Provider.of<SettingsProvider>(context).darkMode
                  ? AppTheme.darkTheme
                  : AppTheme.lightTheme,

          home: FutureBuilder<LoginStatus>(
            future: checkLoginStatus(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                );
              }

              switch (snapshot.data) {
                case LoginStatus.loggedIn:
                  //return StepsTestPage();//TODO
                  return  HomePage();
                case LoginStatus.expired:
                  return SessionExpiredPage();
                default:
                  return LoginPage();
              }
            },
          ),
        );
      },
    );
  }
}
