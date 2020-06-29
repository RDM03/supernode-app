import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_appcenter/flutter_appcenter.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/tip.dart';
import 'package:supernodeapp/common/configs/sys.dart';
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
  
  FlutterAppCenter.checkForUpdate(
    _ctx,
    downloadUrlAndroid: Sys.downloadUrlAndroid,
    dialog: {
      'title': FlutterI18n.translate(_ctx,'update_dialog_title'),
      'subTitle': FlutterI18n.translate(_ctx,'update_dialog_subTitle'),
      'content': FlutterI18n.translate(_ctx,'update_dialog_content'),
      'confirm': FlutterI18n.translate(_ctx,'update_dialog_confirm'),
      'cancel': FlutterI18n.translate(_ctx,'update_dialog_cancel'),
      'downloading': FlutterI18n.translate(_ctx,'update_dialog_downloading')
    }
  ).then((isLatest){
    if(!isLatest){
      Toast.show(FlutterI18n.translate(_ctx,'tip_latest_version'),_ctx,duration: 5);
    }
  });
}
