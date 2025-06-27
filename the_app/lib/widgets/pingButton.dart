import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:the_app/utils/impact.dart';

// Button to ping the server and display its status
class PingButton extends StatelessWidget {
  const PingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: const Icon(Icons.network_ping),
      label: const Text('Ping Server'),
      onPressed: () => _pingServer(context),
    );
  }
}

Future<void> _pingServer(BuildContext context) async {
  final url = Impact.baseURL + Impact.pingEndpoint;
  final uri = Uri.parse(url);
  final scaffoldMessenger = ScaffoldMessenger.of(
    context,
  ); // capture context before await
  final response = await http.get(uri);

  String message;
  if (response.statusCode == 200) {
    message = 'Server is up';
  } else {
    message = 'There is a problem : ${response.statusCode}';
  }

  scaffoldMessenger // the .. is used to call methods on the same object without callaing it each time
    ..removeCurrentSnackBar()
    ..showSnackBar(
      SnackBar(content: Text(message), duration: const Duration(seconds: 3)),
    );
}
