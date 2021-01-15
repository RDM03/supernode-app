import 'package:fish_redux/fish_redux.dart';
import 'package:package_info/package_info.dart';

class AboutState implements Cloneable<AboutState> {
  PackageInfo info;

  String version = '';
  String buildNumber = '';
  String mxVersion;

  @override
  AboutState clone() {
    return AboutState()
      ..version = version
      ..buildNumber = buildNumber
      ..info = info
      ..mxVersion = mxVersion;
  }
}

AboutState initState(Map<String, dynamic> args) {
  return AboutState();
}
