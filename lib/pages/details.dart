import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:folder_splitter/pages/success.dart';

import '../controller/directory_controller.dart';
import '../controller/split_controller.dart';
import '../controller/utils.dart';

class DirectoryDetails extends StatefulWidget {
  Directory selectedDir;
  bool splitType;

  DirectoryDetails(this.selectedDir, this.splitType, {super.key});

  @override
  State<DirectoryDetails> createState() => _DirectoryDetailsState();
}

class _DirectoryDetailsState extends State<DirectoryDetails> {
  final TextEditingController ammountController = TextEditingController();
  final TextEditingController sizeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Folder Details - ${widget.splitType ? "Peso" : "Quantità"}",
          style: const TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xff202020),
      ),
      backgroundColor: const Color(0xff202020),
      body: !widget.splitType
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
                          text: widget.selectedDir.path,
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
                          text: DirectoryController.getDirSize(
                              widget.selectedDir),
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
                      controller: ammountController,
                      onChanged: (value) {
                        if (int.parse(value) < 1) {
                          BotToast.showText(
                              text:
                                  "I file devono essere minimo 1 per cartella");
                        } else {
                          setState(() {});
                        }
                      },
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
                    onPressed: () async {
                      await Utils.requestPermission();
                      widget.selectedDir =
                          await DirectoryController.getDirectory();
                      setState(() {});
                    },
                    child: const Text("Seleziona un altra cartella"),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: ammountController.text.isEmpty ||
                            ammountController.text == ""
                        ? null
                        : () async {
                            var cancel = Utils.showLoading();
                            try {
                              await SplitController.splitByAmmount(
                                  int.parse(ammountController.text),
                                  widget.selectedDir);
                              if (!context.mounted) {
                                return;
                              }

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SuccessPage()),
                              );
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
                          text: widget.selectedDir.path,
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
                          text: DirectoryController.getDirSize(
                              widget.selectedDir),
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
                        if (sizeController.text.isEmpty ||
                            sizeController.text == "" && int.parse(value) < 2) {
                          BotToast.showText(
                              text: "La grandezza deve superare 1 MB");
                        } else {
                          setState(() {});
                        }
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
                      widget.selectedDir =
                          await DirectoryController.getDirectory();
                      setState(() {});
                    },
                    child: const Text("Seleziona un altra cartella"),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: sizeController.text.isEmpty ||
                            sizeController.text == "" ||
                            int.parse(sizeController.text) < 2
                        ? null
                        : () async {
                            var cancel = Utils.showLoading();
                            try {
                              await SplitController.splitBySize(
                                  int.parse(sizeController.text),
                                  widget.selectedDir);

                              if (!context.mounted) {
                                return;
                              }

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SuccessPage()),
                              );
                            } catch (e) {
                              BotToast.showText(text: e.toString());
                            }
                            cancel();
                          },
                    child: const Text("Dividi in sottocartelle"),
                  ),
                ],
              ),
            ),
    );
  }
}
