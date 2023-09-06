import 'package:flutter/material.dart';

class SuccessPage extends StatelessWidget {
  SuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          "assets/greenIcon.png",
          height: 110,
          width: 110,
        ),
        const SizedBox(height: 15),
        const Text(
          "Grande :)",
          style: TextStyle(
            color: Colors.green,
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
        const SizedBox(height: 15),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Text("L'operazione è stata eseguita con successo!",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
            ),
          ),
        ),
      ],
    );
  }
}
