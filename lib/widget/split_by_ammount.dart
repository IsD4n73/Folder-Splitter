import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:folder_splitter/controller/directory_controller.dart';
import 'package:folder_splitter/controller/split_controller.dart';

import '../controller/utils.dart';

class SplitByAmmount extends StatefulWidget {
  const SplitByAmmount({super.key});

  @override
  State<SplitByAmmount> createState() => _SplitByAmmountState();
}

class _SplitByAmmountState extends State<SplitByAmmount> {
  Directory? selectedDir;
  TextEditingController ammountController = TextEditingController();

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
                      controller: ammountController,
                      decoration: const InputDecoration(
                        labelText: "Quantità di foto per cartella",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: ammountController.text.isEmpty ||
                            ammountController.text == ""
                        ? null
                        : () async {
                            try {
                              await SplitController.splitByAmmount(
                                  int.parse(ammountController.text),
                                  selectedDir!);
                            } catch (e) {
                              BotToast.showText(text: e.toString());
                            }
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
