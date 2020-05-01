import 'package:fish_redux/fish_redux.dart';
import 'package:supernodeapp/page/settings_page/state.dart';


abstract class GlobalBaseState {
  SettingsState get settings;
  set settings(SettingsState settings);
}

class GlobalState implements GlobalBaseState, Cloneable<GlobalState> {
  @override
  SettingsState settings;

  @override
  GlobalState clone() {
    return GlobalState();
  }
}
