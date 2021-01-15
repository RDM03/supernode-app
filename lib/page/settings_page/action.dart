import 'package:fish_redux/fish_redux.dart';

enum SettingsAction { onSettings, blank, onSetScreenshot, localVersion }

class SettingsActionCreator {
  static Action onSettings(String page) {
    return Action(SettingsAction.onSettings, payload: page);
  }

  static Action blank() {
    return Action(SettingsAction.blank);
  }

  static Action onSetScreenshot(bool val) {
    return Action(SettingsAction.onSetScreenshot, payload: val);
  }

  static Action localVersion(String version, String buildNumber) {
    return Action(SettingsAction.localVersion,
        payload: {'version': version, 'buildNumber': buildNumber});
  }
}
