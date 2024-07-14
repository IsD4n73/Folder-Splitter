
import 'package:flutter/material.dart';
import 'package:folder_splitter/controller/directory_controller.dart';
import 'package:folder_splitter/pages/details.dart';
import '../controller/utils.dart';

class SplitByAmmount extends StatefulWidget {
  const SplitByAmmount({super.key});

  @override
  State<SplitByAmmount> createState() => _SplitByAmmountState();
}

class _SplitByAmmountState extends State<SplitByAmmount> {
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
                builder: (context) => DirectoryDetails(selectedDir, false),
              ),
            );
          },
          child: const Text("Seleziona la cartella da dividere"),
        ),
      ),
    );
  }
}
