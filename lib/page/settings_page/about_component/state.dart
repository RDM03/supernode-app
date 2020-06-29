import 'package:fish_redux/fish_redux.dart';

class AboutState implements Cloneable<AboutState> {

  String version = '';
  String buildNumber = '';

  @override
  AboutState clone() {
    return AboutState()
      ..version = version
      ..buildNumber = buildNumber;
  }
}

AboutState initState(Map<String, dynamic> args) {
  return AboutState();
}
