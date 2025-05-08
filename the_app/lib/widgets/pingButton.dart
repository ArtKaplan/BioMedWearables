import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:the_app/utils/impact.dart';

// button to change loggin status and go back to login page

class PingButton extends StatelessWidget {
  const PingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: const Icon(Icons.network_ping),
      label: const Text('Ping Server'),
      onPressed: () => _ping_server(context),
    );
  }
}

_ping_server(BuildContext context) async {
  final url = Impact.baseURL + Impact.pingEndpoint;
  final uri = Uri.parse(url);
  final response = await http.get(uri);
  String message;
  if (response.statusCode == 200) {
    message = 'Server is up';
  } else {
    message = 'There is a problem : ${response.statusCode}';
  }

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(message), duration: const Duration(seconds: 3)),
  );
}
