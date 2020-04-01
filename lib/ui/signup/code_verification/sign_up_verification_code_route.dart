import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:supernodeapp/route.dart';
import 'package:supernodeapp/ui/signup/code_verification/sign_up_code_verification_screen.dart';


class SignUpVerificationRoute extends ARoute {
  static String _path = '/sign_up_verification';
  static String buildPath() => _path;

  @override
  String get path => _path;

  @override
  final TransitionType transition = TransitionType.inFromRight;

  @override
  Widget handlerFunc(BuildContext context, Map<String, dynamic> params) => SignUpCodeVerificationScreen();
}
