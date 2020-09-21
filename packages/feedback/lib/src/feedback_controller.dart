import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:native_screenshot/native_screenshot.dart';

class FeedbackController extends ChangeNotifier {
  bool _isVisible = false;
  Uint8List _screenshot;

  bool get isVisible => _isVisible;
  Uint8List get screenshot => _screenshot;

  Future<void> show() async {
    _isVisible = true;

    final path = await NativeScreenshot.takeScreenshot();
    final file = File(path);
    _screenshot = await file.readAsBytes();

    notifyListeners();
  }

  void hide() {
    _isVisible = false;
    notifyListeners();
  }
}
