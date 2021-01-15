import 'dart:ui';

import 'package:fish_redux/fish_redux.dart';

class LanguageState implements Cloneable<LanguageState> {
  Locale language;

  @override
  LanguageState clone() {
    return LanguageState()..language = language;
  }
}
