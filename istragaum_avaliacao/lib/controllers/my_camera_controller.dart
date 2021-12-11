import 'package:camera/camera.dart';

class MyCameraController {
  late CameraDescription camera;
  static MyCameraController instance = MyCameraController();

  setCamera(CameraDescription camera) {
    this.camera = camera;
  }
}
