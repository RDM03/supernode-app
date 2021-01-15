import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Reducer<SettingsState> buildReducer() {
  return asReducer(
    <Object, Reducer<SettingsState>>{
      SettingsAction.localVersion: _localVersion,
      SettingsAction.blank: _blank,
    },
  );
}

SettingsState _blank(SettingsState state, Action action) {
  final SettingsState newState = state.clone();
  return newState;
}

SettingsState _localVersion(SettingsState state, Action action) {
  Map data = action.payload;

  final SettingsState newState = state.clone();
  return newState
    ..version = data['version']
    ..buildNumber = data['buildNumber'];
}
