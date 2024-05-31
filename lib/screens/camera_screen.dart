import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:handwritten_text_transcriber/services/text_recognition_service.dart';

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? controller;
  String? transcribedText;

  @override
  void initState() {
    super.initState();
    initializeCamera();
  }

  Future<void> initializeCamera() async {
    final cameras = await availableCameras();
    controller = CameraController(cameras[0], ResolutionPreset.high);
    await controller?.initialize();
    setState(() {});
  }

  Future<void> captureAndTranscribeImage() async {
    if (controller != null && controller!.value.isInitialized) {
      final image = await controller!.takePicture();
      final text = await TextRecognitionService().detectText(image.path);
      setState(() {
        transcribedText = text;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (controller == null || !controller!.value.isInitialized) {
      return Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      appBar: AppBar(title: Text('Capture Image')),
      body: Column(
        children: [
          Expanded(
            child: CameraPreview(controller!),
          ),
          ElevatedButton(
            onPressed: captureAndTranscribeImage,
            child: Text('Capture and Transcribe'),
          ),
          if (transcribedText != null) ...[
            SizedBox(height: 20),
            Text(transcribedText!),
          ],
        ],
      ),
    );
  }
}
