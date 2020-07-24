import 'package:fish_redux/fish_redux.dart';
import 'package:package_info/package_info.dart';

class AboutState implements Cloneable<AboutState> {
  PackageInfo info;

  String version = '';
  String buildNumber = '';

  @override
  AboutState clone() {
    return AboutState()
      ..version = version
      ..buildNumber = buildNumber
      ..info = info;
  }
}

AboutState initState(Map<String, dynamic> args) {
  return AboutState();
}
