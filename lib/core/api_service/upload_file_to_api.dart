import 'dart:io';

import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

Future<MultipartFile> uploadXFileToApi(XFile file) async {
  return await MultipartFile.fromFile(file.path,
      filename: file.path.split('/').last);
}

Future<MultipartFile> uploadFileToApi(File file) async {
  return await MultipartFile.fromFile(file.path,
      filename: file.path.split('/').last);
}
