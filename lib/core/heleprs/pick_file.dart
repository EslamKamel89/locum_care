import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:locum_care/core/heleprs/snackbar.dart';

Future<File?> pickFile() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles();

  if (result != null) {
    File file = File(result.files.single.path!);
    return file;
  } else {
    showSnackbar('Error', "You didn't pick a file", true);
    return null;
  }
}
