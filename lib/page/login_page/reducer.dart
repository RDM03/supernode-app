import 'package:fish_redux/fish_redux.dart';
import 'package:supernodeapp/common/utils/utils.dart';
import 'package:supernodeapp/global_store/action.dart';
import 'package:supernodeapp/global_store/store.dart';
import 'state.dart';
import 'action.dart';

Reducer<LoginState> buildReducer() {
  return asReducer(
    <Object, Reducer<LoginState>>{
      LoginAction.selectedSuperNode: _selectedSuperNode,
      LoginAction.isObscureText: _isObscureText,
      LoginAction.superNodeListVisible: _superNodeListVisible,
      LoginAction.clickLogo: _clickLogo,
    },
  );
}

LoginState _selectedSuperNode(LoginState state, Action action) {
  final LoginState newState = state.clone();
  GlobalStore.store.dispatch(GlobalActionCreator.choiceSuperNode(action.payload));
  return newState
    ..currentSuperNode = action.payload
    ..showSuperNodeList = false;
}

LoginState _isObscureText(LoginState state, Action action) {
  final LoginState newState = state.clone();
  return newState..isObscureText = !state.isObscureText;
}

LoginState _superNodeListVisible(LoginState state, Action action) {
  final LoginState newState = state.clone();
  newState.showSuperNodeList = action.payload;
  if (newState.count != 7)
    newState.count = 0;
  return newState;
}

LoginState _clickLogo(LoginState state, Action action) {
  final LoginState newState = state.clone();
  newState.count = state.count + 1;
  mLog("count", "${newState.count}");
  return newState..count;
}
