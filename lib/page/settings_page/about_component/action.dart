import 'package:fish_redux/fish_redux.dart';
import 'package:package_info/package_info.dart';

enum AboutAction { onCheckForUpdate, initPackageInfo, initMxVersion }

class AboutActionCreator {
  static Action onCheckForUpdate() {
    return const Action(AboutAction.onCheckForUpdate);
  }

  static Action onInitPackageInfo(PackageInfo info) {
    return Action(AboutAction.initPackageInfo, payload: info);
  }

  static Action onInitMxVersion(String version) {
    return Action(AboutAction.initMxVersion, payload: version);
  }
}
