import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_mapbox_native/flutter_mapbox_native.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:supernodeapp/app_cubit.dart';
import 'package:supernodeapp/app_state.dart';
import 'package:supernodeapp/common/components/column_spacer.dart';
import 'package:supernodeapp/common/components/page/page_body.dart';
import 'package:supernodeapp/common/components/panel/panel_frame.dart';
import 'package:supernodeapp/common/components/summary_row.dart';
import 'package:supernodeapp/common/utils/currencies.dart';
import 'package:supernodeapp/common/utils/screen_util.dart';
import 'package:supernodeapp/common/utils/tools.dart';
import 'package:supernodeapp/configs/images.dart';
import 'package:supernodeapp/configs/sys.dart';
import 'package:supernodeapp/page/home_page/bloc/supernode/btc/cubit.dart';
import 'package:supernodeapp/page/home_page/bloc/supernode/dhx/cubit.dart';
import 'package:supernodeapp/page/home_page/bloc/supernode/gateway/cubit.dart';
import 'package:supernodeapp/page/home_page/bloc/supernode/gateway/state.dart';
import 'package:supernodeapp/page/home_page/bloc/supernode/user/cubit.dart';
import 'package:supernodeapp/page/home_page/bloc/supernode/user/state.dart';
import 'package:supernodeapp/page/home_page/cubit.dart';
import 'package:supernodeapp/page/home_page/state.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/font.dart';

import '../shared.dart';
import 'account_widget.dart';
import 'token_widget.dart';

class UserTab extends StatelessWidget {
  Widget totalGateways(BuildContext context, SupernodeUserState snState,
      GatewayState gatewayState) {
    return Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 30),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(FlutterI18n.translate(context, "miner"),
                    style: kBigBoldFontOfBlack),
                Spacer(),
                GestureDetector(
                  onTap: () async {
                    if (!context.read<AppCubit>().state.isDemo) {
                      await Navigator.of(context)
                          .pushNamed('add_gateway_page', arguments: {
                        'fromPage': 'home',
                      });
                      await context.read<GatewayCubit>().refreshGateways();
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Token.supernodeDhx.color.withOpacity(.2),
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 4.0),
                      child: Text(
                        '+ ${FlutterI18n.translate(context, 'add_miner')}',
                        style: MiddleFontOfColor(color: Token.supernodeDhx.color),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          PanelFrame(rowTop: EdgeInsets.only(top: 10),
            child: SummaryRow(
              key: Key('totalGatewaysDashboard'),
              loading: snState.gatewaysRevenueUsd.loading,
              image: AppImages.gateways,
              title: FlutterI18n.translate(context, 'total_gateways'),
              number: '${gatewayState.gatewaysTotal.value ?? '0'}',
              subtitle: FlutterI18n.translate(context, 'profit'),
              price:
              '${Tools.priceFormat(snState.gatewaysRevenue.value)} MXC (${Tools.priceFormat(snState.gatewaysRevenueUsd.value)} USD)',
            ),
          )
        ]);
  }

  Widget totalGatewaysDemo(BuildContext context) {
    return PanelFrame(
      child: unlockDhxLayer(
        context,
        SummaryRow(
          key: Key('totalGatewaysDashboard'),
          image: AppImages.gateways,
          title: FlutterI18n.translate(context, 'total_gateways'),
          number: '3',
          subtitle: FlutterI18n.translate(context, 'profit'),
          price: '200 USD',
        ),
      ),
    );
  }

  Widget unlockDhxLayer(BuildContext context, Widget child) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => loginSupernode(context),
      child: Stack(
        children: [
          child,
          Positioned.fill(
            child: Container(
              color: colorDhx.withOpacity(0.85),
              alignment: Alignment.center,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.lock_open,
                    color: Colors.white,
                  ),
                  Text(
                    'Unlock Supernode Account',
                    style: kSmallFontOfWhite,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget body(BuildContext context,
      {bool parachainConnected, bool supernodeConnected}) {
    return RefreshIndicator(
      displacement: 10,
      onRefresh: () async {
        await context.read<SupernodeUserCubit>().refresh();
        if (context.read<HomeCubit>().state.displayTokens.contains(Token.supernodeDhx))
          await context.read<SupernodeDhxCubit>().refresh();
        if (context.read<HomeCubit>().state.displayTokens.contains(Token.btc))
          await context.read<SupernodeBtcCubit>().refresh();
      },
      child: PageBody(
        children: [
          AccountWidget(),
          TokenHomePageWidget(),
          if (supernodeConnected)
            BlocBuilder<GatewayCubit, GatewayState>(
              buildWhen: (a, b) => a.gatewaysTotal != b.gatewaysTotal,
              builder: (ctx, gatewayState) =>
                  BlocBuilder<SupernodeUserCubit, SupernodeUserState>(
                buildWhen: (a, b) =>
                    a.gatewaysRevenueUsd != b.gatewaysRevenueUsd ||
                    a.gatewaysRevenue != b.gatewaysRevenue,
                builder: (ctx, state) =>
                    totalGateways(context, state, gatewayState),
              ),
            )
          else
            totalGatewaysDemo(context),
          if (supernodeConnected)
            BlocBuilder<SupernodeUserCubit, SupernodeUserState>(
              buildWhen: (a, b) =>
                  a?.geojsonList != b?.geojsonList ||
                  a?.locationPermissionsGranted !=
                      b?.locationPermissionsGranted,
              builder: (ctx, state) => PanelFrame(
                key: ValueKey('homeMapbox'),
                height: 263,
                child: state.locationPermissionsGranted
                    ? FlutterMapboxNative(
                        mapStyle: Sys.mapTileStyle,
                        center: CenterPosition(
                          target: LatLng(0, 0),
                          zoom: 0,
                          animated: true,
                        ),
                        maximumZoomLevel: 12,
                        clusters: state?.geojsonList ?? [],
                        myLocationEnabled: true,
                        myLocationTrackingMode: MyLocationTrackingMode.None,
                        onFullScreenTap: () {
                          Navigator.of(context).pushNamed('mapbox_gl_page',
                              arguments: {'list': state?.geojsonList});
                        },
                      )
                    : Container(),
              ),
            )
          else
            PanelFrame(
              key: ValueKey('homeMapbox'),
              height: 263,
              child: unlockDhxLayer(
                context,
                FlutterMapboxNative(
                  mapStyle: Sys.mapTileStyle,
                  center: CenterPosition(
                    target: LatLng(0, 0),
                    zoom: 0,
                    animated: true,
                  ),
                  maximumZoomLevel: 12,
                  clusters: [],
                  myLocationEnabled: true,
                  myLocationTrackingMode: MyLocationTrackingMode.None,
                  onFullScreenTap: () {
                    Navigator.of(context)
                        .pushNamed('mapbox_gl_page', arguments: {'list': []});
                  },
                ),
              ),
            ),
          smallColumnSpacer(),
        ],
      ),
    );
  }

  Future<void> openCalculator(BuildContext context) {
    final gatewaysRevenue =
        context.read<SupernodeUserCubit>().state.gatewaysRevenue.value ?? 0;
    final mining =
        context.read<SupernodeUserCubit>().state.devicesRevenue.value ?? 0;
    return Navigator.of(context).pushNamed('calculator_page', arguments: {
      'balance': context.read<SupernodeUserCubit>().state.balance.value,
      'staking': context.read<SupernodeUserCubit>().state.stakedAmount.value,
      'mining': gatewaysRevenue + mining,
      'isDemo': context.read<AppCubit>().state.isDemo,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        title: BlocBuilder<SupernodeCubit, SupernodeState>(
          buildWhen: (a, b) => a?.session?.node != b?.session?.node,
          builder: (ctx, state) => CachedNetworkImage(
            imageUrl: state?.session?.node?.logo ?? '',
            placeholder: (a, b) => Image.asset(
              AppImages.placeholder,
              height: s(40),
            ),
            height: s(40),
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          key: Key('calculatorButton'),
          icon: FaIcon(
            FontAwesomeIcons.calculator,
            color: Colors.black,
          ),
          onPressed: () => openCalculator(context),
        ),
        actions: [
          IconButton(
            key: Key('settingsButton'),
            icon: Icon(
              Icons.settings,
              color: Colors.black,
            ),
            onPressed: () => openSettings(context),
          )
        ],
      ),
      backgroundColor: Color(0xFFEBEFF2),
      body: BlocBuilder<HomeCubit, HomeState>(
        buildWhen: (a, b) =>
            a.parachainUsed != b.parachainUsed ||
            a.supernodeUsed != b.supernodeUsed,
        builder: (ctx, s) => body(
          context,
          supernodeConnected: s.supernodeUsed,
          parachainConnected: s.parachainUsed,
        ),
      ),
    );
  }
}
