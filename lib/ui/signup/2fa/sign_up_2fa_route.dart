import 'package:fluro/fluro.dart';
import 'package:flutter/widgets.dart';
import 'package:supernodeapp/ui/signup/2fa/sign_up_2fa_screen.dart';

import '../../../route.dart';

class SignUp2faRoute extends ARoute {
  static String _path = '/sign_up_2fa';

  static String buildPath() => _path;

  @override
  String get path => _path;

  @override
  final TransitionType transition = TransitionType.inFromRight;

  @override
  Widget handlerFunc(BuildContext context, Map<String, dynamic> params) =>
      SignUp2faScreen();
}
