import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  FlutterErrorDetails errorDetails;
  ErrorPage({required this.errorDetails, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Image(image: AssetImage("assets/dirIcon.png")),
        Text(
          kDebugMode ? errorDetails.summary.toString() : "OPS...",
          style: const TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
        const Text(
          "C'è stato un errore nell applicazione, prova a riavviare",
          style: TextStyle(
            color: Colors.white,
            fontSize: 15,
          ),
        ),
      ],
    );
  }
}
