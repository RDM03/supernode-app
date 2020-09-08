import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/update_dialog.dart';
import 'package:supernodeapp/common/daos/demo/server_info.dart';
import 'package:supernodeapp/common/daos/server_info.dart';
import 'package:supernodeapp/global_store/store.dart';
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

ServerInfoDao _buildServerInfoDao() {
  if (GlobalStore.state.settings.isDemo) {
    return DemoServerInfoDao();
  }
  return ServerInfoDao();
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

  _buildServerInfoDao().appServerVersion().then(
      (info) => ctx.dispatch(AboutActionCreator.onInitMxVersion(info.version)));
}
