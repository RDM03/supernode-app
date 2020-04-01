import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:supernodeapp/route.dart';
import 'package:supernodeapp/ui/signup/profile/sign_up_profile_screen.dart';

class SignUpProfileRoute extends ARoute {
  static String _path = '/sign_up_profile';

  static String buildPath() => _path;

  @override
  String get path => _path;

  @override
  final TransitionType transition = TransitionType.inFromRight;

  @override
  Widget handlerFunc(BuildContext context, Map<String, dynamic> params) =>
      SignUpProfileScreen();
}
