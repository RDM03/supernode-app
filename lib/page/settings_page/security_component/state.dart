import 'package:fish_redux/fish_redux.dart';

class SecurityState implements Cloneable<SecurityState> {

  @override
  SecurityState clone() {
    return SecurityState();
  }
}

SecurityState initState(Map<String, dynamic> args) {
  return SecurityState();
}
