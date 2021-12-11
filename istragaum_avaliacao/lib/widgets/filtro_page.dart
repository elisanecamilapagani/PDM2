import 'dart:ui';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:istragaum/controllers/my_camera_controller.dart';
import 'package:istragaum/widgets/filtro_seletor.dart';
import 'dart:io';
import 'package:istragaum/services/image_service.dart';

@immutable
class ImagePage2 extends StatefulWidget {
  final XFile img;
  const ImagePage2({Key? key, required this.img}) : super(key: key);

  @override
  _ImagePageState createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage2> {
  final _filters = [
    Colors.white,
    ...List.generate(
      Colors.primaries.length,
      (index) => Colors.primaries[(index * 4) % Colors.primaries.length],
    )
  ];

  final _filterColor = ValueNotifier<Color>(Colors.white);

  void _onFilterChanged(Color value) {
    _filterColor.value = value;
  }

  late CameraController _controller;
  // Guarda a Future que indicará o status
  // de inicialização da câmera
  late Future<void> _initializeControllerFuture;

  void initState() {
    super.initState();
    _controller = CameraController(
        MyCameraController.instance.camera, ResolutionPreset.medium);
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Colors.white,
        title: Text(
          'Istragaum',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Billabong',
            fontSize: 35,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        bottom: PreferredSize(
          child: Container(
            color: Colors.black26,
            height: 1,
          ),
          preferredSize: Size.fromHeight(1),
        ),
      ),
      body: Material(
        color: Colors.black,
        child: Stack(
          children: [
            Positioned.fill(
              child: _buildPhotoWithFilter(),
            ),
            Positioned(
              left: 0.0,
              right: 0.0,
              bottom: 40,
              child: _buildFilterSelector(),
            ),
            Positioned(
              left: 0.0,
              right: 0.0,
              bottom: 0.0,
              child: IconButton(
                icon: const Icon(Icons.check),
                onPressed: () async {
                  try {
                    await _initializeControllerFuture;
                    ImageService service = ImageService();

                    await service.saveImage(widget.img);
                    Navigator.pushNamed(context, '/home');
                  } catch (e) {
                    print(e);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPhotoWithFilter() {
    return ValueListenableBuilder(
      valueListenable: _filterColor,
      builder: (context, value, child) {
        final color = value as Color;
        return Image.file(File(widget.img.path),
            color: color.withOpacity(0.5),
            colorBlendMode: BlendMode.color,
            fit: BoxFit.cover);
      },
    );
  }

  Widget _buildFilterSelector() {
    return FilterSelector(
      onFilterChanged: _onFilterChanged,
      filters: _filters,
    );
  }
}
