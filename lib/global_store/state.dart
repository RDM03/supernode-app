import 'package:fish_redux/fish_redux.dart';
import 'package:supernodeapp/global_store/state/super_node_state.dart';
import 'package:supernodeapp/page/settings_page/state.dart';

abstract class GlobalBaseState {
  SettingsState get settings;

  set settings(SettingsState settings);
}

class GlobalState with SuperNodeStore implements Cloneable<GlobalState>, GlobalBaseState {
  @override
  SettingsState settings;

  @override
  GlobalState clone() {
    return GlobalState()..superModel = superModel;
  }
}
