import 'package:fish_redux/fish_redux.dart';
import 'package:supernodeapp/common/daos/users_dao.dart';

import 'action.dart';
import 'state.dart';

Reducer<ProfileState> buildReducer() {
  return asReducer(
    <Object, Reducer<ProfileState>>{
      ProfileAction.jwtUpdate: _jwtUpdate,
      ProfileAction.showConfirmation: _showConfirmation,
      ProfileAction.unbind: _unbind,
      ProfileAction.bindShopifyStep : _bindShopifyStep,
    },
  );
}

ProfileState _jwtUpdate(ProfileState state, Action action) {
  Map data = action.payload;

  final ProfileState newState = state.clone();
  return newState
    ..reloadProfile = true
    ..username = data['username']
    ..email = data['email'];
}

ProfileState _showConfirmation(ProfileState state, Action action) {
  bool data = action.payload;

  final ProfileState newState = state.clone();
  return newState
    ..showWechatUnbindConfirmation = data;
}

ProfileState _unbind(ProfileState state, Action action) {
  String service = action.payload;
  final ProfileState newState = state.clone();
  if (service == UserApi.extServiceWeChat) {
    newState.wechatExternalUsername = '';
  }
  if (service == UserApi.extServiceShopify) {
    newState.shopifyExternalUsername = '';
  }
  return newState
    ..reloadProfile = true;
}

ProfileState _bindShopifyStep(ProfileState state, Action action) {
  int step = action.payload;
  final ProfileState newState = state.clone();
  if (step == 3)
    return newState
      ..shopifyExternalUsername = state.shopifyEmailCtl.text
      ..reloadProfile = true
      ..showBindShopifyStep = 0;
  return newState
    ..showBindShopifyStep = step;
}