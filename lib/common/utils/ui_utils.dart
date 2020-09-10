import 'package:flutter/material.dart';

class UiUtils {
  UiUtils._internal();

  static Widget buildSafeBottom(BuildContext context) {
    final padding = MediaQuery.of(context).padding;
    return SizedBox(height: padding.bottom);
  }

  static Stream<Duration> timeLeftStream(DateTime time) async* {
    Duration difference() => time?.difference(DateTime.now());
    final stream =
        Stream.periodic(Duration(seconds: 1)).map((_) => difference());
    final diff = difference();
    if (diff == null) {
      yield null;
    } else {
      yield difference();
      yield* stream;
    }
  }
}
