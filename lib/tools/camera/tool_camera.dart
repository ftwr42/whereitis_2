import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:whereitis_2/model/DBTool.dart';

import '../../model/db/wii_file.dart';

class CameraStreamWidget extends StatefulWidget {
  late Rx<WFile> wFile;
  CameraStreamWidget({super.key, required this.wFile});

  @override
  _CameraStreamWidgetState createState() => _CameraStreamWidgetState();
}

class _CameraStreamWidgetState extends State<CameraStreamWidget> {
  late CameraController _controller;
  late List<CameraDescription> _cameras;
  bool _isCameraInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    _cameras = await availableCameras();
    if (_cameras.isNotEmpty) {
      _controller = CameraController(
        _cameras.firstWhere((camera) => camera.lensDirection == CameraLensDirection.back),
        ResolutionPreset.medium,
      );

      _controller.initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {
          _isCameraInitialized = true;
        });
      });
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  void _openCameraApp() async {
    // Beispiel URL, muss für das spezifische Gerät angepasst werden
    var image = await _controller.takePicture();

    print("NAME: ${image.name}");
    var name = DBTool.putImageToFS(file: image);
    name.then((value) => widget.wFile.refresh());

    widget.wFile.value.image = image.name;

    // const url = 'camera://';
    // if (await canLaunch(url)) {
    //   await launch(url);
    // } else {
    //   print('Could not launch $url');
    // }
  }

  @override
  Widget build(BuildContext context) {
    if (!_isCameraInitialized) {
      return Center(child: CircularProgressIndicator());
    }

    return GestureDetector(
      onTap: _openCameraApp,
      child: CameraPreview(_controller),
    );
  }
}

// void main() => runApp(MaterialApp(home: Scaffold(body: CameraStreamWidget())));‘
