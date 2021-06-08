import 'package:fish_redux/fish_redux.dart';

class WechatLoginState implements Cloneable<WechatLoginState> {
  @override
  WechatLoginState clone() {
    return WechatLoginState();
  }
}

WechatLoginState initState(Map<String, dynamic> args) {
  return WechatLoginState();
}
