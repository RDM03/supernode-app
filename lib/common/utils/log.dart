import 'dart:developer';

import 'package:flutter/material.dart';

void mLog(String name, dynamic object) {
  L.dTag(name, "$object");
}

/// log
class L {
  static Map<String, bool> _mode = {
    "ERROR": true,
    "WARN": true,
    "INFO": true,
    "DEBUG": true,
  };

  static void openOnly(String mode) => _mode[mode] = true;

  static void closeOnly(String mode) => _mode[mode] = false;

  static void openAll() => open("DEBUG");

  static void closeAll() => close("ERROR");

  static void open(String mode) {
    _mode[mode] = true;
    var keys = _mode.keys;
    for (var key in keys) {
      if (key != mode)
        _mode[key] = true;
      else
        break;
    }
  }

  static void close(String mode) {
    _mode[mode] = false;
    var keys = _mode.keys.toList().reversed;
    for (var key in keys) {
      if (key != mode)
        _mode[key] = false;
      else
        break;
    }
  }

  static void _log(String mode, String tag, String prefixMessage, String message) {
    if (_mode[mode] || (!_mode.containsKey(mode) && _mode["DEBUG"])) {
      log("$prefixMessage : $message", name: "$mode] [ $tag ", time: DateTime.now());
    }
  }

  static void _tag(String mode, String tag, String message) => _log(mode, tag, "", message);

  static void _notTag(String mode, String message) => _log(mode, "", "", message);

  static void dTag(String tag, String message) => _tag("DEBUG", tag, message);

  static void d(String message) => _notTag("DEBUG", message);

  static void iTag(String tag, String message) => _tag("INFO", tag, message);

  static void i(String message) => _notTag("INFO", message);

  static void wTag(String tag, String message) => _tag("WARN", tag, message);

  static void w(String message) => _notTag("WARN", message);

  static void eTag(String tag, String message) => _tag("ERROR", tag, message);

  static void e(String message) => _notTag("ERROR", message);

  static void runtime() => _log("PROJECT", "${WidgetsBinding.instance.runtimeType}", "", "RUNTIME MESSAGE");
}
