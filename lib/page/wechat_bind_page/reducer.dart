import 'package:fish_redux/fish_redux.dart';
import 'state.dart';
import 'action.dart';

Reducer<WechatBindState> buildReducer() {
  return asReducer(
    <Object, Reducer<WechatBindState>>{
      WechatBindAction.isObscureText: _isObscureText,
    },
  );
}

WechatBindState _isObscureText(WechatBindState state, Action action) {
  final WechatBindState newState = state.clone();
  return newState..isObscureText = !state.isObscureText;
}
