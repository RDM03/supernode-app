import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_mapbox_native/flutter_mapbox_native.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:supernodeapp/app_cubit.dart';
import 'package:supernodeapp/common/components/column_spacer.dart';
import 'package:supernodeapp/common/components/page/page_body.dart';
import 'package:supernodeapp/common/components/panel/panel_frame.dart';
import 'package:supernodeapp/common/components/summary_row.dart';
import 'package:supernodeapp/common/utils/currencies.dart';
import 'package:supernodeapp/common/utils/tools.dart';
import 'package:supernodeapp/configs/images.dart';
import 'package:supernodeapp/configs/sys.dart';
import 'package:supernodeapp/page/home_page/bloc/supernode/gateway/cubit.dart';
import 'package:supernodeapp/page/home_page/bloc/supernode/gateway/state.dart';
import 'package:supernodeapp/page/home_page/bloc/supernode/user/cubit.dart';
import 'package:supernodeapp/page/home_page/bloc/supernode/user/state.dart';
import 'package:supernodeapp/page/home_page/cubit.dart';
import 'package:supernodeapp/page/home_page/state.dart';
import 'package:supernodeapp/page/login_page/entry_supernode.dart';
import 'package:supernodeapp/page/login_page/supernode_login_page/view.dart';
import 'package:supernodeapp/route.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/font.dart';

import '../shared.dart';
import 'account_widget.dart';
import 'token_widget.dart';

class UserTab extends StatelessWidget {
  Widget totalGateways(BuildContext context, SupernodeUserState snState,
      GatewayState gatewayState) {
    return PanelFrame(
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
    );
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

  Widget totalDevices(BuildContext context, SupernodeUserState state) {
    return PanelFrame(
      child: SummaryRow(
        key: Key('totalDevicesDashboard'),
        loading: false,
        image: AppImages.devices,
        title: FlutterI18n.translate(context, 'total_devices'),
        number: '${state.devicesTotal.value ?? '0'}',
        subtitle: FlutterI18n.translate(context, 'cost'),
        price:
            '${Tools.priceFormat(state.devicesRevenue.value)} MXC (${Tools.priceFormat(state.devicesRevenueUsd.value)} USD)',
      ),
    );
  }

  Widget totalDevicesDemo(BuildContext context) {
    return PanelFrame(
      child: unlockDhxLayer(
        context,
        SummaryRow(
          key: Key('totalDevicesDashboard'),
          loading: false,
          image: AppImages.devices,
          title: FlutterI18n.translate(context, 'total_devices'),
          number: '0',
          subtitle: FlutterI18n.translate(context, 'cost'),
          price: '0 USD',
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
      onRefresh: () => context.read<SupernodeUserCubit>().refresh(),
      child: PageBody(
        children: [
          AccountWidget(),
          TokenWidget(),
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
                  a?.devicesRevenueUsd != b?.devicesRevenueUsd ||
                  a?.devicesRevenue != b?.devicesRevenue ||
                  a?.devicesTotal != b?.devicesTotal,
              builder: (ctx, state) => totalDevices(context, state),
            )
          else
            totalDevicesDemo(context),
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
        title: Text('Home', style: kBigBoldFontOfBlack),
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
