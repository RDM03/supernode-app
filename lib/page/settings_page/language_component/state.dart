import 'package:fish_redux/fish_redux.dart';
import 'package:supernodeapp/global_store/store.dart';
import 'package:supernodeapp/page/settings_page/state.dart';

class LanguageState implements Cloneable<LanguageState> {
  String language = '';

  @override
  LanguageState clone() {
    return LanguageState()..language = language;
  }
}

LanguageState initState(Map<String, dynamic> args) {
  SettingsState settings = GlobalStore.store.getState().settings;

  return LanguageState()..language = settings.language ?? 0;
}
