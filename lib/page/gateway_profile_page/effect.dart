import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:supernodeapp/app_cubit.dart';
import 'package:supernodeapp/common/components/map_box.dart';
import 'package:supernodeapp/common/repositories/supernode/dao/gateways.dart';
import 'package:supernodeapp/common/repositories/supernode/dao/wallet.dart';
import 'package:supernodeapp/common/repositories/supernode_repository.dart';
import 'package:supernodeapp/common/utils/gateway.dart';
import 'package:supernodeapp/configs/images.dart';
import 'package:supernodeapp/page/home_page/bloc/supernode/gateway/state.dart';
import 'action.dart';
import 'state.dart';

Effect<GatewayProfileState> buildEffect() {
  return combineEffects(<Object, Effect<GatewayProfileState>>{
    Lifecycle.initState: _initState,
    // GatewayProfileAction.action: _onAction,
  });
}

WalletDao _buildWalletDao(Context<GatewayProfileState> ctx) {
  return ctx.context.read<SupernodeRepository>().wallet;
}

GatewaysDao _buildGatewaysDao(Context<GatewayProfileState> ctx) {
  return ctx.context.read<SupernodeRepository>().gateways;
}

void _initState(Action action, Context<GatewayProfileState> ctx) {
  SchedulerBinding.instance.addPostFrameCallback((_) async {
    GatewayItem profile = ctx.state.profile;
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
  final fromDateSource = Mining.weekStartDate;
  final toDateSource = Mining.weekEndDate;

  Map data = {
    'gatewayMac': ctx.state.profile.id,
    'orgId': ctx.context.read<SupernodeCubit>().state.orgId,
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
