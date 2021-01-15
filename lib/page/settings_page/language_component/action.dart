import 'dart:ui';

import 'package:fish_redux/fish_redux.dart';

enum LanguageAction { select, onChange }

class LanguageActionCreator {
  static Action select(Locale language) {
    return Action(LanguageAction.select, payload: language);
  }

  static Action onChange(String language) {
    return Action(LanguageAction.onChange, payload: language);
  }
}
