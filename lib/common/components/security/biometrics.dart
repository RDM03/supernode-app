import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:supernodeapp/common/utils/log.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

class Biometrics {
  Biometrics._();

  static final LocalAuthentication _localAuthentication = LocalAuthentication();

  static BiometricType _availableBiometric;

  static BiometricType get availableBiometric => _availableBiometric ?? getBiometricType();

  static Future<bool> canCheckBiometrics() async {
    bool canCheckBiometric = false;
    try {
      canCheckBiometric = await _localAuthentication.canCheckBiometrics;
    } on PlatformException catch (e) {
      log('canCheckBiometric Exception ', e);
    }
    return canCheckBiometric;
  }

  static Future<BiometricType> getBiometricType() async {
    if (_availableBiometric != null) return _availableBiometric;

    final biometricTypes = await _localAuthentication.getAvailableBiometrics();
    if (biometricTypes.contains(BiometricType.fingerprint)) {
      _availableBiometric = BiometricType.fingerprint;
    } else {
      _availableBiometric = BiometricType.face;
    }
    return _availableBiometric;
  }

  static Future<void> authenticate(
    BuildContext context, {
    @required String localizedReason,
    @required VoidCallback authenticateCallback,
    VoidCallback failAuthenticateCallBack,
  }) async {
    try {
      final didAuthenticate = await _localAuthentication.authenticateWithBiometrics(
        localizedReason: localizedReason,
      );
      if (didAuthenticate) {
        authenticateCallback.call();
      } else {
        failAuthenticateCallBack?.call();
      }
    } on PlatformException catch (e) {
      log('PlatformException ', e);
    }
  }
}
