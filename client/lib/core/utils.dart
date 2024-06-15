import 'dart:async';
import 'dart:io';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:client/core/widgets/snackbar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String title, String message,
    ContentType contentType) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      snackbar.showSnackbar(
        context: context,
        title: title,
        message: message,
        contentType: contentType,
      ),
    );
}
Future<File?> pickImage() async {
    try {
      final filePickerRes = await FilePicker.platform.pickFiles(
        type: FileType.image,
      );
      if (filePickerRes != null) {
        return File(filePickerRes.files.first.xFile.path);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<File?> pickAudio() async {
    try {
      final filePickerRes = await FilePicker.platform.pickFiles(
        type: FileType.audio,
      );
      if (filePickerRes != null) {
        return File(filePickerRes.files.first.xFile.path);
      }
      return null;
    } catch (e) {
      return null;
    }
  }
