import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/app_cubit.dart';

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

  final locale =
      language == 'auto' ? Localizations.localeOf(context) : Locale(language);
  await FlutterI18n.refresh(context, locale);

  ctx.context.read<AppCubit>().setLocale(locale);

  _rebuildAllChildren(ctx.context);

  ctx.dispatch(LanguageActionCreator.select(locale));
}
