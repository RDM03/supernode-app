import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/update_dialog.dart';
import 'package:toast/toast.dart';

import 'action.dart';
import 'state.dart';

Effect<AboutState> buildEffect() {
  return combineEffects(<Object, Effect<AboutState>>{
    AboutAction.onCheckForUpdate: _onCheckForUpdate,
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
