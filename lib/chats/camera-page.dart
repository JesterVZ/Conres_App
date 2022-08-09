import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CameraPage extends StatefulWidget {
  final List<CameraDescription>? cameras;
  const CameraPage({this.cameras, Key? key}) : super(key: key);

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late CameraController controller;
  XFile? pictureFile;

  @override
  void initState() {
    super.initState();
    controller = CameraController(
      widget.cameras![0],
      ResolutionPreset.max,
    );
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return const SizedBox(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return Scaffold(
        body: Stack(fit: StackFit.expand, children: [
      Expanded(
        child: Center(
          child: SizedBox(
            child: CameraPreview(controller),
          ),
        ),
      ),
      Positioned(
          width: MediaQuery.of(context).size.width,
          bottom: 20,
          child: Container(
            child: ElevatedButton(
              onPressed: () async {
                pictureFile = await controller.takePicture();
                setState(() {});
              },
              child: const Text('Capture Image'),
            ),
          ))
    ]));
  }
}
