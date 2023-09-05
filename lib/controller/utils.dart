import 'dart:io';
import 'dart:math';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

import 'package:permission_handler/permission_handler.dart';

class Utils {
  // bytes to legible format
  static String formatBytes(int bytes, [int decimals = 2]) {
    if (bytes <= 0) return "0 B";
    const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
    var i = (log(bytes) / log(1024)).floor();
    return '${(bytes / pow(1024, i)).toStringAsFixed(decimals)} ${suffixes[i]}';
  }

  // request permission for file
  static Future<void> requestPermission() async {
    if (!(await Permission.manageExternalStorage.request().isGranted) ||
        !(await Permission.storage.request().isGranted)) {
      await [
        Permission.manageExternalStorage,
        Permission.storage,
      ].request();
    }
  }

  // loading widget
  static Function() showLoading() {
    return BotToast.showCustomLoading(
      toastBuilder: (cancelFunc) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  // list file
  static Future<List<FileSystemEntity>> listFiles(Directory dir) async {
    List<FileSystemEntity> files = [];

    for (FileSystemEntity f in await dir.list(recursive: true).toList()) {
      if (FileSystemEntity.isDirectorySync(f.path)) {
        files.addAll(await listFiles(Directory(f.path)));
      } else {
        files.add(f);
      }
    }

    return files;
  }
}
