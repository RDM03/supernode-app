import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

class Reg {
  static String isEmpty(String value) {
    if (value.trim().isEmpty) {
      return 'reg_required';
    }

    return null;
  }

  static bool isAddress(String value) {
    var reg = RegExp(r'^[A-z\d]{47,48}$');
    return reg.hasMatch(value);
  }

  static String isEmail(String value) {
    RegExp emailRule = new RegExp(
        r'''^(?:[a-z0-9\u4e00-\u9fa5!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])$''');

    if (!emailRule.hasMatch(value)) {
      return 'reg_invalid_email';
    }

    return null;
  }

  static String isBigger(String value, int total) {
    if (value.trim().length < total) {
      return 'reg_morethan';
    }

    return null;
  }

  static String isEqual(String value1, String value2, String ext) {
    if (value1 != value2) {
      return 'reg_password_not_same';
    }

    return null;
  }

  static String isNumber(String value) {
    bool isNaN = double.parse(value).isNaN;
    //RegExp numberRule = new RegExp(r'^[0-9]\d*$');

    if (isNaN) {
      //!numberRule.hasMatch(value.trim())
      return 'reg_not_number';
    }

    return null;
  }

  static String onValidEmail(BuildContext context, String value) {
    String res = isEmpty(value);
    if (res != null) return FlutterI18n.translate(context, res);

    res = isEmail(value.toLowerCase());
    if (res != null) {
      return FlutterI18n.translate(context, res);
    }

    return null;
  }

  static String onValidPassword(BuildContext context, String value) {
    String res = Reg.isEmpty(value);
    if (res != null) return FlutterI18n.translate(context, res);

    String pattern =
        r'^(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!#$%&*+,-./<=>?@[\]^_`|~]).{8,}$';

    RegExp passwordRule = new RegExp(pattern);

    if (!passwordRule.hasMatch(value.trim())) {
      return FlutterI18n.translate(context, 'reg_invalid_password');
    }

    return null;
  }

  static String onValidNumber(BuildContext context, String value,
      {bool isShowError = true}) {
    String res = Reg.isEmpty(value);
    if (res != null)
      return FlutterI18n.translate(context, isShowError ? res : '');

    res = Reg.isNumber(value);

    if (res != null) {
      return FlutterI18n.translate(context, isShowError ? res : '');
    }

    return null;
  }

  static String onNotEmpty(BuildContext context, String value,
      {bool isShowError = true}) {
    String res = Reg.isEmpty(value);
    if (res != null)
      return FlutterI18n.translate(context, isShowError ? res : '');

    return null;
  }

  /// NOT USED. Please remove @deprecated if you want to use it
  @deprecated
  static String onValidAmount(BuildContext context, String value,
      {bool isShowError = true}) {
    String res = Reg.isEmpty(value);
    if (res != null) return FlutterI18n.translate(context, res);

    RegExp numberRule = new RegExp(r'^[1-9]\d*$');

    if (!numberRule.hasMatch(value.trim())) {
      return FlutterI18n.translate(context, 'reg_amount');
    }

    return null;
  }

  static bool onValidSerialNumber(String value) {
    RegExp rule = new RegExp(r'^m\w{8}$|^m\w{10}$', caseSensitive: false);

    return rule.hasMatch(value.trim());
  }
}
