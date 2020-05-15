import 'package:fish_redux/fish_redux.dart';

import '../state.dart';
import 'action.dart';

Reducer<WalletState> buildReducer() {
  return asReducer(
    <Object, Reducer<WalletState>>{
      WalletListAction.action: _onAction,
    },
  );
}

WalletState _onAction(WalletState state, Action action) {
  final WalletState newState = state.clone();
  return newState;
}
