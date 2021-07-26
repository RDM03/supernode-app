import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_mapbox_native/flutter_mapbox_native.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:supernodeapp/app_cubit.dart';
import 'package:supernodeapp/app_state.dart';
import 'package:supernodeapp/common/components/column_spacer.dart';
import 'package:supernodeapp/common/components/loading_flash.dart';
import 'package:supernodeapp/common/components/page/dd_box_spacer.dart';
import 'package:supernodeapp/common/components/page/page_body.dart';
import 'package:supernodeapp/common/components/panel/panel_frame.dart';
import 'package:supernodeapp/common/components/summary_row.dart';
import 'package:supernodeapp/common/components/wallet/title_detail_row.dart';
import 'package:supernodeapp/common/components/widgets/circular_graph.dart';
import 'package:supernodeapp/common/utils/currencies.dart';
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
import 'package:supernodeapp/theme/font.dart';
import 'package:supernodeapp/theme/theme.dart';
import 'package:supernodeapp/theme/spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../shared.dart';
import 'account_widget.dart';
import 'token_widget.dart';

class UserTab extends StatelessWidget {
  Widget totalGateways(BuildContext context, SupernodeUserState snState,
      GatewayState gatewayState) {
    return Column(children: [
      Container(
        padding: EdgeInsets.only(top: 30),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(FlutterI18n.translate(context, "miner"),
                style: FontTheme.of(context).big.primary.bold()),
            Spacer(),
            GestureDetector(
              onTap: () async {
                if (!context.read<AppCubit>().state.isDemo) {
                  await openSupernodeMiner(context, hasSkip: false);
                  await context.read<GatewayCubit>().refreshGateways();
                }
              },
              child: Container(
                decoration: BoxDecoration(
                    color: ColorsTheme.of(context).dhxBlue20,
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 4.0),
                  child: Text(
                    '+ ${FlutterI18n.translate(context, 'add_miner')}',
                    style: MiddleFontOfColor(
                        color: Token.supernodeDhx.ui(context).color),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      GestureDetector(
          onTap: () => context.read<HomeCubit>().changeTab(
                HomeCubit.MINER_TAB,
              ),
          child: PanelFrame(
              rowTop: EdgeInsets.only(top: 10),
              child: Column(
                children: [
                  DDBoxSpacer(
                    height: SpacerStyle.small,
                  ),
                  Container(
                    margin: kRoundRow2010,
                    child: Flex(
                      direction: Axis.horizontal,
                      children: [
                        minerPanel(context,
                            name:
                                FlutterI18n.translate(context, 'health_score'),
                            percentage: gatewayState.health.value,
                            loading: gatewayState.health.loading),
                        DDBoxSpacer(width: SpacerStyle.small),
                        minerPanel(context,
                            name: FlutterI18n.translate(context, 'fuel_tank'),
                            percentage: gatewayState.miningFuelHealth.value,
                            loading: gatewayState.miningFuelHealth.loading),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      TitleDetailRow(
                        loading: gatewayState.gatewaysTotal.loading,
                        name: FlutterI18n.translate(context, 'miner_owner'),
                        value: (gatewayState.gatewaysTotal.value == null)
                            ? '--'
                            : '${gatewayState.gatewaysTotal.value}',
                        token: '',
                      ),
                      BlocBuilder<SupernodeUserCubit, SupernodeUserState>(
                          buildWhen: (a, b) =>
                              a.gatewaysRevenue != b.gatewaysRevenue,
                          builder: (ctx, state) => TitleDetailRow(
                              loading: state.gatewaysRevenue.loading,
                              name: FlutterI18n.translate(
                                  context, 'total_mining_revenue'),
                              value: (state.gatewaysRevenue.value == null)
                                  ? '--'
                                  : '${Tools.priceFormat(state.gatewaysRevenue.value)}')),
                      TitleDetailRow(
                        loading: gatewayState.miningFuel.loading,
                        name: FlutterI18n.translate(
                            context, 'total_fueled_amount'),
                        value: (gatewayState.miningFuel.value == null)
                            ? '--'
                            : '${Tools.priceFormat(gatewayState.miningFuel.value)}',
                      )
                    ],
                  ),
                  DDBoxSpacer(height: SpacerStyle.small)
                ],
              ))),
    ]);
  }

  Widget minerPanel(BuildContext context,
      {String name, double percentage, bool loading = false}) {
    Color color;
    percentage = (percentage ?? 0.0) * 100;

    if (percentage > 10) {
      color = ColorsTheme.of(context).mxcBlue;
    } else {
      color = ColorsTheme.of(context).minerHealthRed;
    }

    return Expanded(
        child: Column(
      children: [
        CircularGraph(
          percentage,
          color,
          child: Container(
            alignment: Alignment.center,
            height: double.infinity,
            margin: kOuterRowBottom10,
            child: loadableWidget(
              loading: loading,
              child: percentage == null
                  ? Text(
                      '-- %',
                      style: FontTheme.of(context).middle.primary.bold(),
                    )
                  : Text(
                      '${Tools.priceFormat(percentage)} %',
                      style: FontTheme.of(context).middle.primary.bold(),
                    ),
            ),
          ),
          size: 100,
          paddingSize: 6,
          lineWidth: 8,
        ),
        DDBoxSpacer(
          height: SpacerStyle.small,
        ),
        Text(name, style: FontTheme.of(context).small())
      ],
    ));
  }

  Widget totalGatewaysDemo(BuildContext context) {
    return PanelFrame(
      child: unlockDhxLayer(
        context,
        SummaryRow(
          key: Key('totalGatewaysDashboard'),
          image: AssetImage(AppImages.gateways),
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
              color: ColorsTheme.of(context).dhxBlue80,
              alignment: Alignment.center,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.lock_open,
                    color: ColorsTheme.of(context).textPrimaryAndIcons,
                  ),
                  Text(
                    'Unlock Supernode Account',
                    style: FontTheme.of(context).small.label(),
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
        if (context
            .read<HomeCubit>()
            .state
            .displayTokens
            .contains(Token.supernodeDhx))
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
                height: 263.h,
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
              height: 263.h,
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
        backgroundColor: ColorsTheme.of(context).primaryBackground,
        elevation: 0,
        title: BlocBuilder<SupernodeCubit, SupernodeState>(
          buildWhen: (a, b) => a?.session?.node != b?.session?.node,
          builder: (ctx, state) => CachedNetworkImage(
            imageUrl: ColorsTheme.of(context).getSupernodeLogo(state?.session?.node),
            placeholder: (a, b) => Image.asset(
              AppImages.placeholder,
              height: 40.h,
            ),
            height: 40.h,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          key: Key('calculatorButton'),
          icon: FaIcon(
            FontAwesomeIcons.calculator,
            color: ColorsTheme.of(context).textPrimaryAndIcons,
          ),
          onPressed: () => openCalculator(context),
        ),
        actions: [
          IconButton(
            key: Key('settingsButton'),
            icon: Icon(
              Icons.settings,
              color: ColorsTheme.of(context).textPrimaryAndIcons,
            ),
            onPressed: () => openSettings(context),
          )
        ],
      ),
      backgroundColor: ColorsTheme.of(context).primaryBackground,
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
