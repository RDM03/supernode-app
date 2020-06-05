import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<QRCodeState> buildReducer() {
  return asReducer(
    <Object, Reducer<QRCodeState>>{
      // VerificationCodeAction.action: _onAction,
    },
  );
}

QRCodeState _onAction(QRCodeState state, Action action) {
  final QRCodeState newState = state.clone();
  return newState;
}