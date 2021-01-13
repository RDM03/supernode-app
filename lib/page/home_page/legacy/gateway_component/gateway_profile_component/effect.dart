import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/scheduler.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:supernodeapp/common/components/map_box.dart';
import 'package:supernodeapp/common/daos/chart_dao.dart';
import 'package:supernodeapp/common/daos/demo/gateways_dao.dart';
import 'package:supernodeapp/common/daos/demo/wallet_dao.dart';
import 'package:supernodeapp/common/daos/gateways_dao.dart';
import 'package:supernodeapp/common/daos/wallet_dao.dart';
import 'package:supernodeapp/configs/images.dart';
import 'package:supernodeapp/global_store/store.dart';
import 'package:supernodeapp/page/home_page/legacy/gateway_component/item_state.dart';
import 'package:supernodeapp/page/settings_page/state.dart';
import 'action.dart';
import 'state.dart';

Effect<GatewayProfileState> buildEffect() {
  return combineEffects(<Object, Effect<GatewayProfileState>>{
    Lifecycle.initState: _initState,
    // GatewayProfileAction.action: _onAction,
  });
}

WalletDao _buildWalletDao(Context<GatewayProfileState> ctx) {
  return ctx.state.isDemo ? DemoWalletDao() : WalletDao();
}

GatewaysDao _buildGatewaysDao(Context<GatewayProfileState> ctx) {
  return ctx.state.isDemo ? DemoGatewaysDao() : GatewaysDao();
}

void _initState(Action action, Context<GatewayProfileState> ctx) {
  SchedulerBinding.instance.addPostFrameCallback((_) async {
    GatewayItemState profile = ctx.state.profile;
    LatLng markerPiont = LatLng(
        (profile.location['latitude'] as num).toDouble(),
        (profile.location['longitude'] as num).toDouble());
    var ctl = ctx.state.mapCtl;

    ctl.myLatLng = markerPiont;
    try {
      await ctl.moveToMyLatLng();
    } catch (_) {}

    Future.delayed(Duration(seconds: 1), () {
      ctl.addSymbol(MapMarker(
        point: markerPiont,
        image: AppImages.gateways,
      ));
    });

    await _miningInfo(ctx);
    await _frame(ctx);
  });
}

/// Request MiningInfo
Future<void> _miningInfo(Context<GatewayProfileState> ctx) async {
  SettingsState settingsData = GlobalStore.store.getState().settings;
  final fromDateSource = Mining.weekStartDate;
  final toDateSource = Mining.weekEndDate;

  Map data = {
    'gatewayMac': ctx.state.profile.id,
    'orgId': settingsData.selectedOrganizationId,
    'fromDate': DateTime.utc(
            fromDateSource.year, fromDateSource.month, fromDateSource.day)
        .toIso8601String(),
    'tillDate':
        DateTime.utc(toDateSource.year, toDateSource.month, toDateSource.day)
            .toIso8601String(),
  };

  try {
    WalletDao dao = _buildWalletDao(ctx);
    var res = await dao.miningIncomeGateway(data);
    List items = res['dailyStats'] ?? res['data'];

    ctx.dispatch(GatewayProfileActionCreator.miningInfo(items));
  } catch (err) {
    // tip(ctx.context, 'WalletDao miningInfo: $err');
  }
}

/// Request Gateway Frame
Future<void> _frame(Context<GatewayProfileState> ctx) async {
  var now = DateTime.now();
  var beforeDay = now.subtract(Duration(days: 7));
  Map data = {
    'gatewayID': ctx.state.profile.id,
    'interval': 'DAY',
    'startTimestamp': beforeDay.toIso8601String() + 'Z',
    'endTimestamp': now.toIso8601String() + 'Z'
  };

  try {
    GatewaysDao dao = _buildGatewaysDao(ctx);
    var res = await dao.frames(data['gatewayID'], data);
    List items = res['result'] as List;

    ctx.dispatch(GatewayProfileActionCreator.gatewayFrame(items));
  } catch (err) {
    // tip(ctx.context, 'GatewaysDao frames: $err');
  }
}