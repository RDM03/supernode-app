import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:supernodeapp/theme/colors.dart';

class Loading {
  bool _enabled = true;
  bool get enabled => _enabled;

  final BuildContext _loadingContext;

  Loading._(this._loadingContext);

  static Future<Loading> show(BuildContext context) {
    final completer = Completer<Loading>();
    showCupertinoDialog(
      context: context,
      builder: (ctx) {
        final loading = Loading._(ctx);
        completer.complete(loading);
        return loadingView();
      },
    );
    return completer.future;
  }

  void hide() {
    if (enabled) {
      Navigator.of(_loadingContext).pop();
      _enabled = false;
    }
  }
}

Widget loadingView() {
  return Container(
    alignment: Alignment.center,
    child: Container(
      width: 100,
      height: 100,
      // decoration: BoxDecoration(
      //   color: Colors.white,
      //   borderRadius: BorderRadius.all(Radius.circular(10)),
      // ),
      alignment: Alignment.center,
      child: SizedBox(
        width: 50.0,
        height: 50.0,
        child: SpinKitPulse(
          color: buttonPrimaryColor,
          size: 50.0,
        ),
      ),
    ),
  );
}
