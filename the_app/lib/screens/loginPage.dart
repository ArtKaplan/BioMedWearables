import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_app/screens/homePage.dart';
import 'package:the_app/utils/impact.dart';
import 'package:http/http.dart' as http;
import 'package:the_app/provider/settings_provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController userController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _isLoading = false;

  @override // called when widget is removed from widget tree
  void dispose() {
    userController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void getGDPR4(){
    showDialog( // taken from https://www.dhiwise.com/post/how-to-build-customizable-pop-ups-with-flutter-dialog
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: RichText(
            text: TextSpan(
              style: Theme.of(context).textTheme.bodyLarge,
              children: [
                TextSpan(text: 'Consent\n', style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(
                  text: '• Do you agree to the collection and processing of your steps, heartrate and any additional information you provide in settings?\n'
                ),
                TextSpan(
                  text: '• Are you aware of the information included below?\n \n'
                ),
                TextSpan(
                  text: 'For any questions or for the full removal of your account, including all connected data, contact us at', style: TextStyle(fontStyle: FontStyle.italic)
                ),
                TextSpan(
                  text: ' privacy@stepoutside.it \n'
                ),
                TextSpan(
                  text: 'Complaints may be made to', style: TextStyle(fontStyle: FontStyle.italic)
                ),
                TextSpan(
                  text: ' Garante per la Protezione dei Dati Personal (e-mail front office: urp@gpdp.it)'
                ),
              ],
            ),
          ),
            actions: <Widget>[
              TextButton(
                child: Text('Yes'),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const HomePage()),
                    //MaterialPageRoute(builder: (_) => const StepsTestPage()),//DEBUG 
                    
                    (route) => false,
                  );
                },
              ),
              TextButton(
                child: Text('No (you cannot use the application)'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  void getGDPR3(){
      showDialog( // taken from https://www.dhiwise.com/post/how-to-build-customizable-pop-ups-with-flutter-dialog
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: RichText(
            text: TextSpan(
              style: Theme.of(context).textTheme.bodyLarge,
              children: [
                TextSpan(text: 'Additional personal data\n', style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(
                  text: 'To enhance your experience, you can add additional personal data in the settings. This data can be easily editted and removed in settings at any time. The data you entered in the settings is the only additional data stored at our back-end.'
                ),
              ],
            ),
          ),
            actions: <Widget>[
              TextButton(
                child: Text('Continue →'),
                onPressed: () {
                  Navigator.of(context).pop();
                  getGDPR4();
                },
              ),
            ],
          );
        },
      );
    }

  void getGDPR2(){
      showDialog( // taken from https://www.dhiwise.com/post/how-to-build-customizable-pop-ups-with-flutter-dialog
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: RichText(
            text: TextSpan(
              style: Theme.of(context).textTheme.bodyLarge,
              children: [
                TextSpan(text: 'Which data will we collect automatically?\n', style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(
                  text: 'For basic functionality, we need to collect and process your'
                ),
                TextSpan(
                  text: ' steps ', style: TextStyle(fontStyle: FontStyle.italic)
                ),
                TextSpan(
                  text: 'and'
                ),
                TextSpan(
                  text: ' heart rate ', style: TextStyle(fontStyle: FontStyle.italic)
                ),
                TextSpan(
                  text: 'from your wearable. This information is necessary for the operation of this application.'
                ),
              ],
            ),
          ),
            actions: <Widget>[
              TextButton(
                child: Text('Continue →'),
                onPressed: () {
                  Navigator.of(context).pop();
                  getGDPR3();
                },
              ),
            ],
          );
        },
      );
    }

  void getGDPR(){
      showDialog( // taken from https://www.dhiwise.com/post/how-to-build-customizable-pop-ups-with-flutter-dialog
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: RichText(
            text: TextSpan(
              style: Theme.of(context).textTheme.bodyLarge,
              children: [
                TextSpan(text: 'Privacy notice \n', style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(
                  text: 'Step Outside highly values your privacy. To make it simple for you, let us explain which of your data we will collect and process, and how you can edit or delete them.'
                ),
              ],
            ),
          ),
            actions: <Widget>[
              TextButton(
                child: Text('Continue →'),
                onPressed: () {
                  Navigator.of(context).pop();
                  getGDPR2();
                },
              ),
            ],
          );
        },
      );
    }

  Future<void> _tryLogin() async {

    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final username = userController.text;
    final password = passwordController.text;

    try {
      if (await _isServerOnline()) {
        if (await _isCredentialsCorrect(username, password)) {
          _setUsernameAndPassord(username, password);
          if (!mounted) return;
          await _setLoggedIn();
          if (!mounted) return;
          // hierrr
          getGDPR();
        } else {
          if (!mounted) return; //mounted = is part of a tree
          _showMessage('Wrong credentials');
        }
      } else {
        if (!mounted) return;
        _showMessage('Cannot reach server');
      }
    } catch (e) {
      if (!mounted) return;
      _showMessage('An error occurred: $e');
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  //check with the server if the credentials are corrects and saves token
  Future<bool> _isCredentialsCorrect(String username, String password) async {
    final url = Impact.baseURL + Impact.tokenEndpoint;
    final uri = Uri.parse(url);
    final body = {'username': username, 'password': password};

    final response = await http.post(uri, body: body);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final accessToken = json['access'];
      final refreshToken = json['refresh'];

      final sp = await SharedPreferences.getInstance();
      await sp.setString('access', accessToken);
      await sp.setString('refresh', refreshToken);

      return true;
    } else {
      print('Token request failed: ${response.statusCode} - ${response.body}');
    }


    return false;
  }

  // adds the username and password to shared preferences
  Future<void> _setUsernameAndPassord(username, password) async {
    final sp = await SharedPreferences.getInstance();
    await sp.setString('username', username);
    await sp.setString('password', password);
    final settings = SettingsProvider(sp);
    await settings.init();
  }

  // pings the server
  Future<bool> _isServerOnline() async {
    final url = Impact.baseURL + Impact.pingEndpoint;
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    return response.statusCode == 200;
  }

  // set the loggin state and set the time of login
  Future<void> _setLoggedIn() async {
    final sp = await SharedPreferences.getInstance();
    await sp.setBool('login_status', true);
    await sp.setString('last_login', DateTime.now().toIso8601String());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login Page')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(30, 50, 30, 15),
                  child: Image.asset('lib/pictures/logo.png'),
                ),
                TextFormField(
                  controller: userController,
                  decoration: const InputDecoration(
                    labelText: 'Username',
                    border: OutlineInputBorder(),
                    hintText: 'Enter your username',
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your username';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                    hintText: 'Enter your password',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _tryLogin,
                    child:
                        _isLoading
                            ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                            : const Text('Login'),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed:
                      _isLoading
                          ? null
                          : () async {
                            await _setLoggedIn();
                            if (!mounted) return;
                            final sp = await SharedPreferences.getInstance();
                            await sp.setString('username', 'debug');
                            final settings = SettingsProvider(sp);
                            await settings.init();
                            getGDPR();
                          },
                  child: const Text('Login (debug)'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}