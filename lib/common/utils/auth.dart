import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/daos/settings_dao.dart';
import 'package:supernodeapp/data/super_node_bean.dart';
import 'package:supernodeapp/global_store/store.dart';
import 'package:supernodeapp/main.dart';
import 'package:supernodeapp/page/settings_page/state.dart';

import 'navigator.dart';

Future<void> logOut(BuildContext context) async {
  SettingsState settingsData = GlobalStore.store.getState().settings;
  if (settingsData != null) {
    settingsData.userId = '';
    settingsData.selectedOrganizationId = '';
    settingsData.organizations = [];
    settingsData.language = '';
    SettingsDao.updateLocal(settingsData);
  }

  Locale locale = Localizations.localeOf(context);
  await FlutterI18n.refresh(context, locale);

  Navigator.of(context).pushNamedAndRemoveUntil('login_page', (_) => false);
}

Future<void> _pushMaintenance() async {
  if (!isCurrent(navigatorKey.currentState, 'under_maintenance_page')) {
    await navigatorKey.currentState.pushNamed('under_maintenance_page');
  }
}

Future<bool> checkMaintenance([SuperNodeBean node]) async {
  if (node == null) {
    await GlobalStore.store.getState().superModel.networkLoad();
    node = GlobalStore.store.getState().superModel.currentNode;
  }
  if (node == null) return true;
  if (node.status == 'maintenance') {
    if (SchedulerBinding.instance.schedulerPhase ==
        SchedulerPhase.persistentCallbacks) {
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        _pushMaintenance();
      });
    } else {
      await _pushMaintenance();
    }
    return false;
  } else if (node.status == 'online') {
    print('node online');
  } else if (node.status == null) {
    print('node status not set');
  } else {
    print('node status unknown');
  }
  return true;
}
