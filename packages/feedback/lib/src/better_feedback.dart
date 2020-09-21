import 'dart:io';
import 'dart:typed_data';

import 'package:feedback/src/feedback_widget.dart';
import 'package:feedback/src/translation.dart';
import 'package:flutter/material.dart';
import 'package:native_screenshot/native_screenshot.dart';

class FeedbackResponse<T> {
  FeedbackResponse(this.text, this.image, this.params);
  final String text;
  final Uint8List image;
  final T params;
}

typedef FeedbackFormBuilder<T> = Widget Function(
    Future<void> Function(String text, [T params]) submit);

class BetterFeedback {
  static Future<FeedbackResponse> show<T>(
    BuildContext context, {
    FeedbackTranslation translation,
    FeedbackFormBuilder<T> formBuilder,
    List<Color> drawColors,
    Color backgroundColor,
  }) async {
    final path = await NativeScreenshot.takeScreenshot();
    final file = File(path);
    final screenshot = await file.readAsBytes();
    final res = await Navigator.of(context).push<FeedbackResponse>(
      MaterialPageRoute(
        builder: (_) => FeedbackWidget<T>(
          screenshot: screenshot,
          backgroundColor: backgroundColor,
          drawColors: drawColors,
          formBuilder: formBuilder,
          translation: translation ?? EnTranslation(),
        ),
      ),
    );
    return res;
  }
}
