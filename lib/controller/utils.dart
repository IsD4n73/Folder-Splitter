import 'dart:math';
import 'package:permission_handler/permission_handler.dart';

class Utils {
  // bytes to legible format
  static String formatBytes(int bytes, [int decimals = 2]) {
    if (bytes <= 0) return "0 B";
    const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
    var i = (log(bytes) / log(1024)).floor();
    return '${(bytes / pow(1024, i)).toStringAsFixed(decimals)} ${suffixes[i]}';
  }

  static void requestPermission() async {
    if (!(await Permission.manageExternalStorage.request().isGranted) ||
        !(await Permission.storage.request().isGranted)) {
      await [
        Permission.manageExternalStorage,
        Permission.storage,
      ].request();
    }
  }
}
