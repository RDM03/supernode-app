import 'dart:ui';

import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<LanguageState> buildReducer() {
  return asReducer(
    <Object, Reducer<LanguageState>>{
      LanguageAction.select: _select,
    },
  );
}

LanguageState _select(LanguageState state, Action action) {
  Locale language = action.payload;

  if (language == state.language) {
    return state;
  }

  final LanguageState newState = state.clone();
  return newState..language = language;
}
