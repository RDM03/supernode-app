import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_i18n/flutter_i18n.dart';

import 'action.dart';
import 'state.dart';

Effect<LanguageState> buildEffect() {
  return combineEffects(<Object, Effect<LanguageState>>{
    LanguageAction.onChange: _onChange,
  });
}

void _rebuildAllChildren(BuildContext context) {
  void rebuild(Element el) {
    el.markNeedsBuild();
    el.visitChildren(rebuild);
  }

  (context as Element).visitChildren(rebuild);
}

void _onChange(Action action, Context<LanguageState> ctx) {
  var context = ctx.context;
  String language = action.payload;

  if (language == ctx.state.language) {
    return;
  }

  _rebuildAllChildren(ctx.context);
  FlutterI18n.refresh(context,
      language == 'auto' ? Localizations.localeOf(context) : Locale(language));

  ctx.dispatch(LanguageActionCreator.change(language));
}
