



import 'package:fluro/fluro.dart';
import 'package:flutter/widgets.dart';
import 'package:supernodeapp/ui/signup/register_gateway/sign_up_register_gateway_screen.dart';
import '../../../route.dart';

class SignUpRegisterGatewayRoute extends ARoute {
  static String _path = '/sign_up_register_gateway';

  static String buildPath() => _path;

  @override
  String get path => _path;

  @override
  final TransitionType transition = TransitionType.inFromRight;

  @override
  Widget handlerFunc(BuildContext context, Map<String, dynamic> params) =>
      SignUpRegisterGatewayScreen();
}
