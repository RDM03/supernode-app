import 'package:fish_redux/fish_redux.dart';

enum SettingsAction { onSettings, blank, onSetScreenshot, localVersion }
enum SettingsOption { app_settings, address_book, about, links, manage_account, profile,
  profileDhx, rate_app, export_mining_data, logout}

extension SettingsOptionExtension on SettingsOption {
  String get label {
    return this.toString().split('.')[1];
  }
}


class SettingsActionCreator {
  static Action onSettings(SettingsOption option) {
    return Action(SettingsAction.onSettings, payload: option);
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
