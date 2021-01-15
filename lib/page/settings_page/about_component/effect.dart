import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' show BuildContext;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/update_dialog.dart';
import 'package:supernodeapp/common/repositories/supernode/dao/server_info.dart';
import 'package:supernodeapp/common/repositories/supernode_repository.dart';
import 'package:toast/toast.dart';
import 'package:package_info/package_info.dart';

import 'action.dart';
import 'state.dart';

Effect<AboutState> buildEffect() {
  return combineEffects(<Object, Effect<AboutState>>{
    AboutAction.onCheckForUpdate: _onCheckForUpdate,
    Lifecycle.initState: _init,
  });
}

ServerInfoDao _buildServerInfoDao(BuildContext context) {
  return context.read<SupernodeRepository>().serverInfo;
}

void _onCheckForUpdate(Action action, Context<AboutState> ctx) {
  var _ctx = ctx.context;

  updateDialog(_ctx).then((isLatest) {
    if (!isLatest) {
      Toast.show(FlutterI18n.translate(_ctx, 'tip_latest_version'), _ctx,
          duration: 5);
    }
  });
}

void _init(Action action, Context<AboutState> ctx) {
  PackageInfo.fromPlatform().then((info) {
    ctx.dispatch(AboutActionCreator.onInitPackageInfo(info));
  });

  _buildServerInfoDao(ctx.context).appServerVersion().then(
      (info) => ctx.dispatch(AboutActionCreator.onInitMxVersion(info.version)));
}
