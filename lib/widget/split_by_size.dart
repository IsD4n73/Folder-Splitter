import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import '../pages/details.dart';
import '../pages/success.dart';
import '../controller/directory_controller.dart';
import '../controller/split_controller.dart';
import '../controller/utils.dart';

class SplitBySize extends StatefulWidget {
  const SplitBySize({super.key});

  @override
  State<SplitBySize> createState() => _SplitBySizeState();
}

class _SplitBySizeState extends State<SplitBySize> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: ElevatedButton(
          onPressed: () async {
            await Utils.requestPermission();
            final selectedDir = await DirectoryController.getDirectory();
            if (!context.mounted) return;

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DirectoryDetails(selectedDir, true),
              ),
            );
          },
          child: const Text("Seleziona la cartella da dividere"),
        ),
      ),
    );
  }
}
