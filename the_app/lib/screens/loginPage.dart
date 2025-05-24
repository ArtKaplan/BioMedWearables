import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_app/screens/homePage.dart';
import 'package:the_app/utils/impact.dart';
import 'package:http/http.dart' as http;

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

  Future<void> _tryLogin() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final username = userController.text;
    final password = passwordController.text;

    try {
      if (await _isServerOnline()) {
        if (await _isCredentialsCorrect(username, password)) {
          if (!mounted) return;
          await _setLoggedIn();
          if (!mounted) return;
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const HomePage()),
            (route) => false,
          );
        } else {
          if (!mounted) return;
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

  //check with the server if the credentials are corrects
  Future<bool> _isCredentialsCorrect(String username, String password) async {
    final url = Impact.baseURL + Impact.tokenEndpoint;
    final uri = Uri.parse(url);
    final body = {'username': username, 'password': password};
    final response = await http.post(uri, body: body);
    return response.statusCode == 200;
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
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const HomePage(),
                              ),
                              (route) => false,
                            );
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