import 'package:flutter/material.dart';
import 'package:the_app/provider/award_provider.dart';
import 'package:the_app/provider/settings_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_app/provider/stepsProvider.dart';
import 'package:the_app/screens/homePage.dart';
import 'package:the_app/screens/loginPage.dart';
import 'package:the_app/screens/sessionExpiredPage.dart';
import 'package:the_app/utils/loginStatus.dart';
import 'package:provider/provider.dart';
import 'package:the_app/theme/app_theme.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized(); 
  // Initialisiere SharedPreferences und prüfe Login-Status
  final prefs = await SharedPreferences.getInstance();
  //final loginStatus = await checkLoginStatus();echo
  final username = await getUsername();
  print(username);
  final settingsProvider = SettingsProvider(prefs);
  await settingsProvider.init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => StepsProvider()),
        //ChangeNotifierProvider(create: (context) => AwardProvider()),
        ChangeNotifierProvider(create: (context) => AwardProvider(Provider.of<StepsProvider>(context, listen: false),)), //to use StepsProvider in AwardProvider without Widget
        //ChangeNotifierProvider(create: (context) => SettingsProvider(prefs)),//..init(username)),
        ChangeNotifierProvider.value(value: settingsProvider),
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
                  /*print('ZZZZZZZZZZZZZZZZZZZZ');            
                  //return StepsTestPage();//debug
                  Provider.of<SettingsProvider>(context, listen: false).init(getUsername().toString());
                  print('YYYYYYYYYYYYYYYYYYYY');*/
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
