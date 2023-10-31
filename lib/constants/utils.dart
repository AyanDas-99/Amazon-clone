import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
}

Future<List<File>> pickImages() async {
  List<File> images = [];
  try {
    FilePickerResult? files = await FilePicker.platform
        .pickFiles(type: FileType.image, allowMultiple: true);
    if (files != null && files.files.isNotEmpty) {
      for (PlatformFile image in files.files) {
        images.add(File(image.path!));
      }
    }
  } catch (e) {
    debugPrint(e.toString());
  }

  return images;
}
