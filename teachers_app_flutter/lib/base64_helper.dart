import 'dart:io';

import 'package:mime/mime.dart';

class Base46Helper {
  static String base46Convert(File file, {bool isAudio = false}) {
    final bytes = file.readAsBytesSync();
    late final mimeType;
    if (isAudio) {
      mimeType = 'application/mp3';
    } else {
      mimeType = lookupMimeType(file.path);
    }
    UriData data = UriData.fromBytes(bytes,
        mimeType: mimeType!, parameters: {}, percentEncoded: false);

    // print(data.toString());
    return data.toString();
  }
}
