import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:locum_care/core/service_locator/service_locator.dart';

Future<File?> pickImage(ImageSource imageSource) async {
  try {
    final ImagePicker picker = serviceLocator();
    final XFile? pickedFile = await picker.pickImage(source: imageSource);
    if (pickedFile != null) {
      return File(pickedFile.path);
    }
    return null;
  } catch (e) {
    return null;
  }
}
