import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

import '../controller/directory_controller.dart';
import '../controller/split_controller.dart';
import '../controller/utils.dart';

class SplitBySize extends StatefulWidget {
  const SplitBySize({super.key});

  @override
  State<SplitBySize> createState() => _SplitBySizeState();
}

class _SplitBySizeState extends State<SplitBySize> {
  Directory? selectedDir;
  TextEditingController sizeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: selectedDir != null
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 10),
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      children: [
                        const TextSpan(text: 'Cartella: '),
                        TextSpan(
                          text: selectedDir!.path,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      children: [
                        const TextSpan(text: 'Grandezza: '),
                        TextSpan(
                          text: DirectoryController.getDirSize(selectedDir!),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: TextField(
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      onChanged: (value) {
                        setState(() {});
                      },
                      controller: sizeController,
                      decoration: const InputDecoration(
                        labelText: "Grandezza di ogni cartella (MB)",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () async {
                      await Utils.requestPermission();
                      await DirectoryController.getDirectory().then((dir) {
                        setState(() {
                          selectedDir = dir;
                        });
                      });
                    },
                    child: const Text("Seleziona un altra cartella"),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: sizeController.text.isEmpty ||
                            sizeController.text == ""
                        ? null
                        : () async {
                            var cancel = Utils.showLoading();
                            try {
                              await SplitController.splitBySize(
                                  int.parse(sizeController.text), selectedDir!);
                            } catch (e) {
                              BotToast.showText(text: e.toString());
                            }
                            cancel();
                          },
                    child: const Text("Dividi in sottocartelle"),
                  ),
                ],
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(10),
              child: ElevatedButton(
                onPressed: () async {
                  await Utils.requestPermission();
                  await DirectoryController.getDirectory().then((dir) {
                    setState(() {
                      selectedDir = dir;
                    });
                  });
                },
                child: const Text("Seleziona la cartella da dividere"),
              ),
            ),
    );
  }
}
