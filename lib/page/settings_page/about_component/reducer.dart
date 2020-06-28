import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<AboutState> buildReducer() {
  return asReducer(
    <Object, Reducer<AboutState>>{
      AboutAction.initPackageInfo: _onInitPackageInfo,
    },
  );
}

AboutState _onInitPackageInfo(AboutState state, Action action) {
  var info = action.payload;
  println(info);
  println(info.version);
  final AboutState newState = state.clone();
  if (info != null) {
    newState.info = info;
  }
  return newState;
}
