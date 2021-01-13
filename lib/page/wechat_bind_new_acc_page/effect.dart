import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/loading.dart';
import 'package:supernodeapp/common/components/tip.dart';
import 'package:supernodeapp/common/utils/auth.dart';
import 'package:supernodeapp/common/daos/dao.dart';
import 'package:supernodeapp/common/daos/users_dao.dart';
import 'package:supernodeapp/common/utils/storage_manager_native.dart';
import 'package:supernodeapp/configs/config.dart';
import 'package:supernodeapp/global_store/store.dart';

import 'action.dart';
import 'state.dart';

Effect<WechatBindNewAccState> buildEffect() {
  return combineEffects(<Object, Effect<WechatBindNewAccState>>{
    WechatBindNewAccAction.onBindNewAcc: _onBindNewAcc,
  });
}

void _onBindNewAcc(Action action, Context<WechatBindNewAccState> ctx) async {
  Dao.ctx = ctx;
  var curState = ctx.state;

  if ((curState.formKey.currentState as FormState).validate()) {
    final loading = await Loading.show(ctx.context);
    try {
      String apiRoot = GlobalStore.state.superModel.currentNode.url;
      Dao.baseUrl = apiRoot;
      UserDao dao = UserDao();
      final email = curState.emailCtl.text.trim();
      final orgName = curState.orgCtl.text.trim();
      final orgDisplayName = curState.displayCtl.text.trim();

      StorageManager.sharedPreferences.setBool(Config.DEMO_MODE, false);
      await _handleBindNewAccRequest(dao, email, orgName, orgDisplayName, apiRoot);

      loading.hide();
      Navigator.pushNamedAndRemoveUntil(ctx.context, 'home_page', (_) => false);
    } catch (err) {
      loading.hide();
      final res = await checkMaintenance();
      if (!res) return;
      tip(ctx.context,
          err?.message ?? FlutterI18n.translate(ctx.context,'error_tip'));
    } finally {
      loading.hide();
    }
  }
}

Future<void> _handleBindNewAccRequest(UserDao dao, String email, String orgName, String orgDisplayName, String apiRoot) async {
  Map data = {
    "email": email,
    "organizationDisplayName": orgDisplayName,
    "organizationName": orgName
  };

  var registerExtUserResult = await dao.registerExternalUser(data);

  await saveLoginResult(dao, registerExtUserResult['jwt'], '', '', apiRoot);
}
