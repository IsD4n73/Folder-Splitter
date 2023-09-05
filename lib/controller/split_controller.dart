import 'dart:io';

import 'package:folder_splitter/controller/utils.dart';

class SplitController {
  static Future<void> splitBySize(int size, Directory dir) async {
    List<FileSystemEntity> fileList = await Utils.listFiles(dir);
  }

  static Future<void> splitByAmmount(int ammount, Directory dir) async {
    List<FileSystemEntity> fileList = await Utils.listFiles(dir);
  }
}
