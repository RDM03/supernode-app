import 'package:fish_redux/fish_redux.dart';
import 'package:supernodeapp/common/repositories/supernode/dao/user.dart';

import 'action.dart';
import 'state.dart';

Reducer<ProfileState> buildReducer() {
  return asReducer(
    <Object, Reducer<ProfileState>>{
      ProfileAction.jwtUpdate: _jwtUpdate,
      ProfileAction.showConfirmation: _showConfirmation,
      ProfileAction.unbind: _unbind,
      ProfileAction.bindShopifyStep: _bindShopifyStep,
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
  return newState..showWechatUnbindConfirmation = data;
}

ProfileState _unbind(ProfileState state, Action action) {
  String service = action.payload;
  final ProfileState newState = state.clone();
  if (service == ExternalUser.weChatService) {
    newState.weChatUser = null;
  }
  if (service == ExternalUser.shopifyService) {
    newState.shopifyUser = null;
  }
  return newState..reloadProfile = true;
}

ProfileState _bindShopifyStep(ProfileState state, Action action) {
  int step = action.payload;
  final ProfileState newState = state.clone();
  if (step == 3)
    return newState
      ..shopifyUser = state.shopifyUser?.copyWith(
            externalUsername: state.shopifyEmailCtl.text,
          ) ??
          ExternalUser(
            externalUsername: state.shopifyEmailCtl.text,
          )
      ..reloadProfile = true
      ..showBindShopifyStep = 0;
  return newState..showBindShopifyStep = step;
}
