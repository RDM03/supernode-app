import 'package:fluro/fluro.dart';
import 'package:flutter/widgets.dart';
import 'package:supernodeapp/ui/signup/mnemonics/sign_up_mnemonic_screen.dart';

import '../../../route.dart';

class SignUpMnemonicsRoute extends ARoute {
  static String _path = '/sign_up_mnemonics';

  static String buildPath() => _path;

  @override
  String get path => _path;

  @override
  final TransitionType transition = TransitionType.inFromRight;

  @override
  Widget handlerFunc(BuildContext context, Map<String, dynamic> params) =>
      SignUpMnemonicsScreen();
}
