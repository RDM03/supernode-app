import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/daos/settings_dao.dart';
import 'package:supernodeapp/global_store/store.dart';
import 'package:supernodeapp/page/settings_page/state.dart';

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

void _onChange(Action action, Context<LanguageState> ctx) async {
  var context = ctx.context;
  String language = action.payload;

  if (language == ctx.state.language) {
    return;
  }

  await FlutterI18n.refresh(context,
      language == 'auto' ? Localizations.localeOf(context) : Locale(language));

  SettingsState settingsData = GlobalStore.store.getState().settings;
  settingsData.language = language;

  SettingsDao.updateLocal(settingsData);
  _rebuildAllChildren(ctx.context);

  ctx.dispatch(LanguageActionCreator.select(language));
}
