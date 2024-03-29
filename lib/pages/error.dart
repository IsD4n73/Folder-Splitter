import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  final FlutterErrorDetails errorDetails;
  const ErrorPage({required this.errorDetails, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff202020),
        title: const Text(
          "Folder Splitter",
          style: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: const Color(0xff202020),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/dirIcon.png",
              height: 110,
              width: 110,
            ),
            const SizedBox(height: 15),
            const Text(
              "OPS :(",
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                kDebugMode
                    ? errorDetails.summary.toString()
                    : "C'è stato un errore nell applicazione, prova a riavviare",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
                softWrap: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
