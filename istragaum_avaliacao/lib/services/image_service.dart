import 'package:camera/camera.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';

class ImageService {
  Future<List<String>> retrieveImages() async {
    final directory = await getApplicationDocumentsDirectory();
    List<String> images = directory
        .listSync()
        .map((item) => item.path)
        .where((item) => item.endsWith(".jpg"))
        .toList();

    return images;
  }

  saveImage(XFile image) async {
    final directory = await getApplicationDocumentsDirectory();
    final String path = directory.path;
    final fileName = basename(image.path);

    await image.saveTo('$path/$fileName');
  }
}
