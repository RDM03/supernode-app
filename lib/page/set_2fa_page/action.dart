import 'package:fish_redux/fish_redux.dart';

enum Set2FAAction {
    initState
  , onSettings
  , onEnterSecurityContinue
  , onEnterRecoveryContinue
  , onQRCodeContinue
  , onSetEnable
  , onSetDisable
  , onSetDisableWithRecoveryCode
  , onRecoveryCodeContinue
  , onVerificationContinue
  , isEnabled
  , isRegenerate
  , onGetTOTPConfig
  , getTOTPConfig
  , onConfirm
}

class Set2FAActionCreator {

  static Action onSettings(String page) {
    return Action(Set2FAAction.onSettings,payload: page);
  }

  static Action onEnterSecurityContinue(String origin) {
    return Action(Set2FAAction.onEnterSecurityContinue,payload: origin);
  }

  static Action onEnterRecoveryContinue() {
    return Action(Set2FAAction.onEnterRecoveryContinue);
  }

  static Action onQRCodeContinue() {
    return Action(Set2FAAction.onQRCodeContinue);
  }

  static Action onVerificationContinue() {
    return const Action(Set2FAAction.onVerificationContinue);
  }

  static Action onRecoveryCodeContinue() {
    return const Action(Set2FAAction.onRecoveryCodeContinue);
  }

  static Action onConfirm() {
    return const Action(Set2FAAction.onConfirm);
  }

  static Action isEnabled(bool data) {
    return Action(Set2FAAction.isEnabled,payload: data);
  }

  static Action isRegenerate(bool data) {
    return Action(Set2FAAction.isRegenerate,payload: data);
  }



  static Action onGetTOTPConfig(int qrCodeSize) {
    return Action(Set2FAAction.onGetTOTPConfig,payload: qrCodeSize);
  }

  static Action getTOTPConfig(Map data) {
    return Action(Set2FAAction.getTOTPConfig,payload: data);
  }

  static Action onSetEnable() {
    return Action(Set2FAAction.onSetEnable);
  }

  static Action onSetDisable() {
    return Action(Set2FAAction.onSetDisable);
  }

  static Action onSetDisableWithRecoveryCode() {
    return Action(Set2FAAction.onSetDisableWithRecoveryCode);
  }

}