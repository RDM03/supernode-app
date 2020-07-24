import 'package:fish_redux/fish_redux.dart';
import 'package:package_info/package_info.dart';

enum AboutAction { onCheckForUpdate, initPackageInfo }

class AboutActionCreator {
  static Action onCheckForUpdate() {
    return const Action(AboutAction.onCheckForUpdate);
  }
  static Action onInitPackageInfo(PackageInfo info) {
    return Action(AboutAction.initPackageInfo, payload: info);
  }
}
