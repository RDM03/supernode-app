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

Effect<WechatBindState> buildEffect() {
  return combineEffects(<Object, Effect<WechatBindState>>{
    WechatBindAction.onBind: _onBind,
  });
}

void _onBind(Action action, Context<WechatBindState> ctx) async {
  Dao.ctx = ctx;
  var curState = ctx.state;

  if ((curState.formKey.currentState as FormState).validate()) {
    final loading = await Loading.show(ctx.context);
    try {
      String apiRoot = GlobalStore.state.superModel.currentNode.url;
      Dao.baseUrl = apiRoot;
      UserDao dao = UserDao();
      final email = curState.usernameCtl.text.trim();
      final password = curState.passwordCtl.text.trim();

      StorageManager.sharedPreferences.setBool(Config.DEMO_MODE, false);
      await _handleBindRequest(dao, email, password, apiRoot);

      loading.hide();
      Navigator.pushReplacementNamed(ctx.context, 'home_page');
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

Future<void> _handleBindRequest(UserDao dao, String email, String password, String apiRoot) async {
  Map data = {'email': email, 'password': password};

  var bindExtUserResult = await dao.bindExternalUser(data);

  await saveLoginResult(dao, bindExtUserResult['jwt'], email, password, apiRoot);
}
