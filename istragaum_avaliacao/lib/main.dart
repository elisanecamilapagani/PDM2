import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:istragaum/controllers/my_camera_controller.dart';
import 'package:istragaum/widgets/istragaum.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  MyCameraController.instance.setCamera(cameras.first);

  runApp(Istragaum());
}
