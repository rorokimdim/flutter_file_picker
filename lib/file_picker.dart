import 'dart:async';

import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

enum FileType {
  ANY,
  PDF,
  IMAGE,
  CAPTURE,
}

class FilePicker {
  static const MethodChannel _channel = const MethodChannel('file_picker');

  static Future<String> _getPath(String type) async => await _channel.invokeMethod(type);

  static Future<String> _getImage(ImageSource type) async {
    var image = await ImagePicker.pickImage(source: type);

    return image?.path;
  }

  static Future<String> getFilePath({FileType type = FileType.ANY}) async {
    switch (type) {
      case FileType.PDF:
        return _getPath('PDF');
      case FileType.IMAGE:
        return _getImage(ImageSource.gallery);
      case FileType.CAPTURE:
        return _getImage(ImageSource.camera);
      default:
        return _getPath('ANY');
    }
  }
}