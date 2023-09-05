import 'dart:io';
import 'package:folder_splitter/controller/utils.dart';

class SplitController {
  static Future<void> splitBySize(int size, Directory dir) async {
    size = 1000000 * (size - 1);
    List<FileSystemEntity> fileList = await Utils.listFiles(dir);
    int current = 0;
    int createdFolder = 1;
    late Directory currentDir;

    for (var f in fileList) {
      if (current == 0) {
        currentDir = await Directory(
                "${dir.path}/${dir.path.split("/").last}_$createdFolder")
            .create(recursive: true);
        createdFolder++;
      }
      current += f.statSync().size;

      await f.rename("${currentDir.path}/${f.path.split("/").last}");

      if (current >= size) {
        current = 0;
      }
    }
  }

  static Future<void> splitByAmmount(int ammount, Directory dir) async {
    List<FileSystemEntity> fileList = await Utils.listFiles(dir);
    int current = 0;
    int createdFolder = 1;
    late Directory currentDir;

    for (var f in fileList) {
      if (current == 0) {
        currentDir = await Directory(
                "${dir.path}/${dir.path.split("/").last}_$createdFolder")
            .create(recursive: true);
        createdFolder++;
      }
      current++;

      await f.rename("${currentDir.path}/${f.path.split("/").last}");

      if (current == ammount) {
        current = 0;
      }
    }
  }
}
