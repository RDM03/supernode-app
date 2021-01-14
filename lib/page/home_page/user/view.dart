import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_mapbox_native/flutter_mapbox_native.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:supernodeapp/app_cubit.dart';
import 'package:supernodeapp/app_state.dart';
import 'package:supernodeapp/common/components/buttons/primary_button.dart';
import 'package:supernodeapp/common/components/column_spacer.dart';
import 'package:supernodeapp/common/components/page/page_body.dart';
import 'package:supernodeapp/common/components/panel/panel_frame.dart';
import 'package:supernodeapp/common/components/profile.dart';
import 'package:supernodeapp/common/components/summary_row.dart';
import 'package:supernodeapp/common/components/wallet/title_detail_row.dart';
import 'package:supernodeapp/common/utils/tools.dart';
import 'package:supernodeapp/configs/images.dart';
import 'package:supernodeapp/common/utils/screen_util.dart';
import 'package:supernodeapp/configs/sys.dart';
import 'package:supernodeapp/page/home_page/bloc/supernode/gateway/cubit.dart';
import 'package:supernodeapp/page/home_page/bloc/supernode/gateway/state.dart';
import 'package:supernodeapp/page/home_page/bloc/supernode/user/cubit.dart';
import 'package:supernodeapp/page/home_page/bloc/supernode/user/state.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/spacing.dart';

import '../shared.dart';

class UserTab extends StatelessWidget {
  isOrgIDloaded() => false;

  Widget mainPanel(BuildContext context) {
    return PanelFrame(
      child: Column(
        children: [
          BlocBuilder<SupernodeUserCubit, SupernodeUserState>(
            buildWhen: (a, b) => a.username != b.username,
            builder: (ctx, state) => ProfileRow(
              keyTitle: ValueKey('homeProfile'),
              keySubtitle: ValueKey('homeProfileSubtitle'),
              name:
                  '${FlutterI18n.translate(context, 'hi')}, ${state.username}',
              // position: (state.organizations.length > 0 &&
              //         state.organizations.first.isAdmin)
              //     ? FlutterI18n.translate(context, 'admin')
              //     : '', RETHINK.TODO
              trailing: SizedBox(
                width: 30,
                child: IconButton(
                  key: ValueKey('calculatorButton'),
                  icon: FaIcon(
                    FontAwesomeIcons.calculator,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    final gatewaysRevenue = context
                            .read<SupernodeUserCubit>()
                            .state
                            .gatewaysRevenue
                            .value ??
                        0;
                    final mining = context
                            .read<SupernodeUserCubit>()
                            .state
                            .devicesRevenue
                            .value ??
                        0;
                    return Navigator.of(context)
                        .pushNamed('calculator_page', arguments: {
                      'balance': context
                          .read<SupernodeUserCubit>()
                          .state
                          .balance
                          .value,
                      'staking': context
                          .read<SupernodeUserCubit>()
                          .state
                          .stakedAmount
                          .value,
                      'mining': gatewaysRevenue + mining,
                      'isDemo': context.read<AppCubit>().state.isDemo,
                    });
                  },
                  iconSize: 20,
                ),
              ),
            ),
          ),
          BlocBuilder<SupernodeUserCubit, SupernodeUserState>(
            buildWhen: (a, b) => a.balance != b.balance,
            builder: (ctx, state) => TitleDetailRow(
              loading: state.balance.loading,
              name: FlutterI18n.translate(context, 'current_balance'),
              value: Tools.priceFormat(state.balance.value),
            ),
          ),
          BlocBuilder<SupernodeUserCubit, SupernodeUserState>(
            buildWhen: (a, b) => a.stakedAmount != b.stakedAmount,
            builder: (ctx, state) => TitleDetailRow(
              loading: state.stakedAmount.loading,
              name: FlutterI18n.translate(context, 'staked_amount'),
              value: Tools.priceFormat(state.stakedAmount.value),
            ),
          ),
          BlocBuilder<SupernodeUserCubit, SupernodeUserState>(
            buildWhen: (a, b) => a.lockedAmount != b.lockedAmount,
            builder: (ctx, state) =>
                state.lockedAmount.value != null && state.lockedAmount.value > 0
                    ? TitleDetailRow(
                        loading: state.lockedAmount.loading,
                        name: FlutterI18n.translate(context, 'staked_amount'),
                        value: Tools.priceFormat(state.lockedAmount.value),
                      )
                    : Container(),
          ),
          BlocBuilder<SupernodeUserCubit, SupernodeUserState>(
            buildWhen: (a, b) => a.totalRevenue != b.totalRevenue,
            builder: (ctx, state) => TitleDetailRow(
              loading: state.totalRevenue.loading,
              name: FlutterI18n.translate(context, 'staking_revenue'),
              value: Tools.priceFormat(state.totalRevenue.value, range: 2),
            ),
          ),
          Container(
            margin: kRoundRow5,
            child: Row(
              children: <Widget>[
                Spacer(),
                PrimaryButton(
                  key: Key('depositButtonDashboard'),
                  buttonTitle: FlutterI18n.translate(context, 'deposit'),
                  onTap: () => openSupernodeDeposit(context),
                ),
                Spacer(),
                BlocBuilder<SupernodeUserCubit, SupernodeUserState>(
                  buildWhen: (a, b) => a.balance != b.balance,
                  builder: (ctx, state) => PrimaryButton(
                    key: Key('withdrawButtonDashboard'),
                    buttonTitle: FlutterI18n.translate(context, 'withdraw'),
                    onTap: state.balance.loading
                        ? null
                        : () => openSupernodeWithdraw(context),
                  ),
                ),
                Spacer(),
                BlocBuilder<SupernodeUserCubit, SupernodeUserState>(
                  buildWhen: (a, b) => a.balance != b.balance,
                  builder: (ctx, state) => PrimaryButton(
                    key: Key('stakeButtonDashboard'),
                    buttonTitle: FlutterI18n.translate(context, 'stake'),
                    onTap: state.balance.loading
                        ? null
                        : () => openSupernodeStake(context),
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        title: BlocBuilder<SupernodeCubit, SupernodeState>(
          buildWhen: (a, b) => a.user.node != b.user.node,
          builder: (ctx, state) => CachedNetworkImage(
            imageUrl: state.user.node?.logo,
            placeholder: (a, b) => Image.asset(
              AppImages.placeholder,
              height: s(40),
            ),
            height: s(40),
          ),
        ),
        actions: [
          IconButton(
              key: Key('settingsButton'),
              icon: Icon(
                Icons.settings,
                color: Colors.black,
              ),
              onPressed: () => null // RETHINK.TODO,
              )
        ],
      ),
      body: RefreshIndicator(
        displacement: 10,
        onRefresh: () => context.read<SupernodeUserCubit>().refresh(),
        child: PageBody(
          children: [
            mainPanel(context),
            BlocBuilder<GatewayCubit, GatewayState>(
              buildWhen: (a, b) => a.gatewaysTotal != b.gatewaysTotal,
              builder: (ctx, gatewayState) =>
                  BlocBuilder<SupernodeUserCubit, SupernodeUserState>(
                buildWhen: (a, b) =>
                    a.gatewaysRevenueUsd != b.gatewaysRevenueUsd ||
                    a.gatewaysRevenue != b.gatewaysRevenue,
                builder: (ctx, state) => PanelFrame(
                  child: SummaryRow(
                    key: Key('totalGatewaysDashboard'),
                    loading: state.gatewaysRevenueUsd.loading,
                    image: AppImages.gateways,
                    title: FlutterI18n.translate(context, 'total_gateways'),
                    number: '${gatewayState.gatewaysTotal.value ?? '0'}',
                    subtitle: FlutterI18n.translate(context, 'profit'),
                    price:
                        '${Tools.priceFormat(state.gatewaysRevenue.value)} MXC (${Tools.priceFormat(state.gatewaysRevenueUsd.value)} USD)',
                  ),
                ),
              ),
            ),
            BlocBuilder<SupernodeUserCubit, SupernodeUserState>(
              buildWhen: (a, b) =>
                  a.devicesRevenueUsd != b.devicesRevenueUsd ||
                  a.devicesRevenue != b.devicesRevenue ||
                  a.devicesTotal != b.devicesTotal,
              builder: (ctx, state) => PanelFrame(
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
              ),
            ),
            BlocBuilder<SupernodeUserCubit, SupernodeUserState>(
              buildWhen: (a, b) =>
                  a.geojsonList != b.geojsonList ||
                  a.locationPermissionsGranted != b.locationPermissionsGranted,
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
                        // minimumZoomLevel: 1,
                        maximumZoomLevel: 12,
                        clusters: state.geojsonList ?? [],
                        myLocationEnabled: true,
                        myLocationTrackingMode: MyLocationTrackingMode.None,
                        onFullScreenTap: () => null, // RETHINK.TODO,
                      )
                    : Container(),
              ),
            ),
            smallColumnSpacer(),
          ],
        ),
      ),
    );
  }
}
