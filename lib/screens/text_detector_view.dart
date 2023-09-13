import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

import '../widgets/detector_view.dart';
import 'package:cargocontrol/widgets/painters/text_detector_painter.dart';

class TextDetectorScreen extends StatefulWidget {
  const TextDetectorScreen({super.key});

  @override
  State<TextDetectorScreen> createState() => _TextDetectorScreenState();
}

class _TextDetectorScreenState extends State<TextDetectorScreen> {
  final _textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
  bool _canProcess = true;
  bool _isBusy = false;
  CustomPaint? _customPaint;
  String? _text;
  final _cameraLensDirection = CameraLensDirection.back;
  bool _recognizedPlate = false;
  String _recognizedPlateNumber = '';

  bool isNumericStringWithLength6(RecognizedText text) {
    RegExp numericRegex = RegExp(r'^\d{6}$');

    for (TextBlock block in text.blocks) {
      if (numericRegex.hasMatch(block.text)) {
        _recognizedPlateNumber = block.text;
        return true;
      }
    }
    return false;
  }

  @override
  void dispose() async {
    _canProcess = false;
    _textRecognizer.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        DetectorView(
          title: 'Text Detector',
          customPaint: _customPaint,
          text: _text,
          onImage: _processImage,
          initialCameraLensDirection: _cameraLensDirection,
        ),
      ]),
    );
  }

  Future<void> _processImage(InputImage inputImage) async {
    if (!_canProcess) return;
    if (_isBusy) return;
    _isBusy = true;
    setState(() {
      _text = '';
    });
    final recognizedText = await _textRecognizer.processImage(inputImage);

    if (isNumericStringWithLength6(recognizedText) &&
        mounted &&
        !_recognizedPlate) {
      print('here');
      _recognizedPlate = true;
      await Future.delayed(const Duration(milliseconds: 200));
      Navigator.pop(context, _recognizedPlateNumber);
    }

    if (inputImage.metadata?.size != null &&
        inputImage.metadata?.rotation != null) {
      final painter = TextRecognizerPainter(
        recognizedText,
        inputImage.metadata!.size,
        inputImage.metadata!.rotation,
        _cameraLensDirection,
      );
      _customPaint = CustomPaint(painter: painter);
    } else {
      _text = 'Recognized text:\n\n${recognizedText.text}';
      // TODO: set _customPaint to draw boundingRect on top of image
      _customPaint = null;
    }

    _isBusy = false;
    if (mounted) {
      setState(() {});
    }
  }
}
