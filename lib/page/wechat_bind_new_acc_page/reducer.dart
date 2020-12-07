import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<WechatBindNewAccState> buildReducer() {
  return asReducer(
    <Object, Reducer<WechatBindNewAccState>>{
      WechatBindNewAccAction.isCheckTerms: _isCheckTerms,
      WechatBindNewAccAction.isCheckSend: _isCheckSend,
    },
  );
}

WechatBindNewAccState _isCheckTerms(WechatBindNewAccState state, Action action) {
  final WechatBindNewAccState newState = state.clone();
  return newState
    ..isCheckTerms = !state.isCheckTerms;
}

WechatBindNewAccState _isCheckSend(WechatBindNewAccState state, Action action) {
  final WechatBindNewAccState newState = state.clone();
  return newState
    ..isCheckSend = !state.isCheckSend;
}