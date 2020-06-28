import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/update_dialog.dart';
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

void _onCheckForUpdate(Action action, Context<AboutState> ctx) {
  var _ctx = ctx.context;
  
  updateDialog(_ctx).then((isLatest){
    if(!isLatest){
      Toast.show(FlutterI18n.translate(_ctx,'tip_latest_version'),_ctx,duration: 5);
    }
  });
}
void _init(Action action, Context<AboutState> ctx) {
  PackageInfo.fromPlatform()
      .then((info){
        println(info.version);
        println(info.appName);
        println(info.packageName);
        ctx.dispatch(AboutActionCreator.onInitPackageInfo(info));
      }
  );
}
