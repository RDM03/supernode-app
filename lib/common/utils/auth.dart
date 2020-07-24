import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/daos/settings_dao.dart';
import 'package:supernodeapp/global_store/store.dart';
import 'package:supernodeapp/page/settings_page/state.dart';

Future<void> logOut(BuildContext context) async {
  SettingsState settingsData = GlobalStore.store.getState().settings;
  settingsData.userId = '';
  settingsData.selectedOrganizationId = '';
  settingsData.organizations = [];
  settingsData.language = '';

  SettingsDao.updateLocal(settingsData);

  Locale locale = Localizations.localeOf(context);
  await FlutterI18n.refresh(context, locale);

  Navigator.of(context).pushNamedAndRemoveUntil('login_page',(_) => false);
}