import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<Set2FAState> buildReducer() {
  return asReducer(
    <Object, Reducer<Set2FAState>>{
      Set2FAAction.isEnabled: _isEnabled,
      Set2FAAction.isRegenerate: _isRegenerate,
      Set2FAAction.getTOTPConfig: _getTOTPConfig,
    },
  );
}

Set2FAState _isEnabled(Set2FAState state, Action action) {
  bool isEnabled = action.payload;

  final Set2FAState newState = state.clone();
  return newState..isEnabled = isEnabled;
}

Set2FAState _isRegenerate(Set2FAState state, Action action) {
  bool regenerate = action.payload;

  final Set2FAState newState = state.clone();
  return newState..regenerate = regenerate;
}

Set2FAState _getTOTPConfig(Set2FAState state, Action action) {
  Map data = action.payload;
  String url = data['url'];
  String secret = data['secret'];
  List<dynamic> recoveryCode = data['recoveryCode'];
  String title = data['title'];
  String qrCode = data['qrCode'];

  final Set2FAState newState = state.clone();
  return newState
    ..url = url
    ..secret = secret
    ..recoveryCode = recoveryCode
    ..title = title
    ..qrCode = qrCode;
}
