import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:folder_splitter/controller/utils.dart';

class DirectoryController {
  static Future<Directory> getDirectory() async {
    String? result = await FilePicker.platform.getDirectoryPath(
      dialogTitle: "Seleziona la cartella da dividere",
    );

    if (result == null) {
      throw Exception("L'operazione è stata annullata");
    }

    return Directory(result);
  }

  static String getDirSize(Directory dir) {
    var files = dir.listSync(recursive: true).toList();
    var dirSize = files.fold(0, (int sum, file) => sum + file.statSync().size);
    return Utils.formatBytes(dirSize);
  }
}
