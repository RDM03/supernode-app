import 'dart:math';
import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:supernodeapp/common/utils/log.dart';

double s(double h) {
  return ScreenUtil.instance.scaleSize(h);
}

class ScreenUtil {
  bool _onInit = false;

  /// Size of the phone in UI Design , dp
  Size _bluePrintSize;
  Size _physicalSize;
  Size _viewBoxSize;
  Size _realSize = Size(0, 0);
  /// The size of the media in logical pixels (e.g, the size of the screen).
  Size _size = Size(0, 0);
  double _pixelRatio;
  double _screenScale;

  ScreenUtil init(double width, double height, BuildContext context) {
    if (isInit() || _onInit) return this;
    _onInit = true;
    try {
      _bluePrintSize = Size(width, height);
      MediaQueryData data = MediaQuery.of(context);
      _pixelRatio = data.devicePixelRatio;
      _realSize = Size(data.size.width + data.padding.left + data.padding.right, data.size.height + data.padding.bottom + data.padding.top);
      _size = data.size;
      _physicalSize = Size(_size.width * _pixelRatio, _size.height * _pixelRatio);
      _viewBoxSize = _getViewBoxSize(_size);
      _screenScale = _physicalSize.width / _physicalSize.height;
      log("Screen Util", toString());
    } catch (e) {} finally {
      _onInit = false;
    }
    return this;
  }

  String toString() => "\nbluePrintWidth: ${_bluePrintSize.width}\n"
      "bluePrintHeight: ${_bluePrintSize.height}\n"
      "screenWidth: ${_size.width}\n"
      "screenHeight: ${_size.height}\n"
      "realSizeWidth: ${_realSize.width}\n"
      "realSizeHeight: ${_realSize.height}\n"
      "viewBoxWidth: ${_viewBoxSize.width}\n"
      "viewBoxHeight: ${_viewBoxSize.height}\n"
      "screenScale: $_screenScale\n"
      "pixelRatio: $_pixelRatio\n";

  bool isInit() => (_size?.width ?? 0) != 0 && (_size?.height ?? 0) != 0 && (_screenScale ?? 0) != 0;

  double get density => ScreenUtil.instance.boxHeight / ScreenUtil.instance.bluePrintHeight;

  double get bluePrintHeight => _bluePrintSize.height;

  double get bluePrintWidth => _bluePrintSize.width;

  double get screenScale => _screenScale;

  double get pixelRatio => _pixelRatio;

  Size get boxSize => _viewBoxSize;

  double get boxWidth => _viewBoxSize.width;

  double get boxHeight => _viewBoxSize.height;

  Size get size => _size;

  double get width => _size.width;

  double get height => _size.height;

  double get realWidth => _realSize.width;

  double get realHeight => _realSize.height;

  double get pixelWidth => _physicalSize.width;

  double get pixelHeight => _physicalSize.height;

  Size _getViewBoxSize(Size size) {
    var widthScale = size.width / (size.height / 9);
    if (widthScale > 16) {
      return Size(size.height * 16 / 9, size.height);
    } else if (widthScale < 16) {
      return Size(size.width, size.width * 9 / 16);
    } else {
      return size;
    }
  }

  double scaleSize(double s) {
    return isInit() ? boxWidth * s / bluePrintWidth : s;
  }

  // singleton
  factory ScreenUtil() => _getInstance();

  static ScreenUtil get instance => _getInstance();
  static ScreenUtil _instance;

  ScreenUtil._internal();

  static ScreenUtil _getInstance() {
    if (_instance == null) {
      _instance = new ScreenUtil._internal();
    }
    return _instance;
  }
}
