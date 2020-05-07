import 'package:fish_redux/fish_redux.dart';
import 'package:supernodeapp/common/daos/settings_dao.dart';
import 'package:supernodeapp/global_store/store.dart';
import 'package:supernodeapp/page/settings_page/state.dart';

import 'action.dart';
import 'state.dart';

Reducer<LanguageState> buildReducer() {
  return asReducer(
    <Object, Reducer<LanguageState>>{
      LanguageAction.select: _select,
    },
  );
}

LanguageState _select(LanguageState state, Action action) {
  String language = action.payload;

  if(language == state.language){
    return state;
  }

  SettingsState settingsData = GlobalStore.store.getState().settings;
  settingsData.language = language;

  SettingsDao.updateLocal(settingsData);

  final LanguageState newState = state.clone();
  return newState
    ..language = language;
}
