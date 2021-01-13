import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_mapbox_native/flutter_mapbox_native.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/spacing.dart';
import 'state.dart';

class UserTab extends StatelessWidget {
  isOrgIDloaded() => false;

  Widget mainPanel(BuildContext context, UserState state) {
    return PanelFrame(
      child: Column(
        children: [
          ProfileRow(
            keyTitle: ValueKey('homeProfile'),
            keySubtitle: ValueKey('homeProfileSubtitle'),
            name: '${FlutterI18n.translate(context, 'hi')}, ${state.username}',
            // position: (state.organizations.length > 0 &&
            //         state.organizations.first.isAdmin)
            //     ? FlutterI18n.translate(context, 'admin')
            //     : '',
            trailing: SizedBox(
              width: 30,
              child: IconButton(
                key: ValueKey('calculatorButton'),
                icon: FaIcon(
                  FontAwesomeIcons.calculator,
                  color: Colors.black,
                ),
                onPressed: () => Navigator.of(context)
                    .pushNamed('calculator_page', arguments: {
                  'balance': context.read<UserState>().balance,
                  'staking': context.read<UserState>().stakedAmount,
                  'mining': context.read<UserState>().gatewaysRevenue.value +
                      context.read<UserState>().devicesRevenue.value,
                  'isDemo': context.read<AppState>().isDemo,
                }),
                iconSize: 20,
              ),
            ),
          ),
          TitleDetailRow(
              loading: state.balance.loading,
              name: FlutterI18n.translate(context, 'current_balance'),
              value: Tools.priceFormat(state.balance.value)),
          TitleDetailRow(
              loading: state.stakedAmount.loading,
              name: FlutterI18n.translate(context, 'staked_amount'),
              value: Tools.priceFormat(state.stakedAmount.value)),
          if (state.lockedAmount.value != null && state.lockedAmount.value > 0)
            TitleDetailRow(
              name: FlutterI18n.translate(context, 'locked_amount'),
              value: Tools.priceFormat(state.lockedAmount.value),
              loading: state.lockedAmount.loading,
            ),
          TitleDetailRow(
            loading: state.totalRevenue.loading,
            name: FlutterI18n.translate(context, 'staking_revenue'),
            value: Tools.priceFormat(state.totalRevenue.value, range: 2),
          ),
          Container(
            margin: kRoundRow5,
            child: Row(
              children: <Widget>[
                Spacer(),
                PrimaryButton(
                  key: Key(isOrgIDloaded()
                      ? 'depositButtonDashboard'
                      : 'depositButtonLoading'),
                  buttonTitle: FlutterI18n.translate(
                      context, isOrgIDloaded() ? 'deposit' : 'loading'),
                  onTap: () => null, // RETHINK.TODO
                ),
                Spacer(),
                PrimaryButton(
                  key: Key('withdrawButtonDashboard'),
                  buttonTitle: FlutterI18n.translate(context, 'withdraw'),
                  onTap: () => null, // RETHINK.TODO
                ),
                Spacer(),
                PrimaryButton(
                  key: Key('stakeButtonDashboard'),
                  buttonTitle: FlutterI18n.translate(context, 'stake'),
                  onTap: () => null, // RETHINK.TODO
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
        title: BlocBuilder<AppCubit, AppState>(
          buildWhen: (a, b) =>
              a.supernode.currentNode != b.supernode.currentNode,
          builder: (ctx, state) => CachedNetworkImage(
            imageUrl: state.supernode.currentNode?.logo,
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
      body: BlocBuilder<UserCubit, UserState>(
        buildWhen: (a, b) => a.username != b.username,
        builder: (context, state) => RefreshIndicator(
          displacement: 10,
          onRefresh: () => context.read<UserCubit>().refresh(),
          child: PageBody(
            children: [
              mainPanel(context, state),
              PanelFrame(
                child: SummaryRow(
                  key: Key('totalGatewaysDashboard'),
                  loading: state.gatewaysRevenueUsd.loading,
                  image: AppImages.gateways,
                  title: FlutterI18n.translate(context, 'total_gateways'),
                  number: '${state.gatewaysTotal.value ?? '0'}',
                  subtitle: FlutterI18n.translate(context, 'profit'),
                  price:
                      '${Tools.priceFormat(state.gatewaysRevenue.value)} MXC (${Tools.priceFormat(state.gatewaysRevenueUsd.value)} USD)',
                ),
              ),
              PanelFrame(
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
              PanelFrame(
                key: ValueKey('homeMapbox'),
                height: 263,
                child: FutureBuilder(
                  builder: (context, builder) {
                    return FlutterMapboxNative(
                      mapStyle: Sys.mapTileStyle,
                      center: CenterPosition(
                        target: LatLng(0, 0),
                        zoom: 0,
                        animated: true,
                      ),
                      // minimumZoomLevel: 1,
                      maximumZoomLevel: 12,
                      clusters: state.geojsonList,
                      myLocationEnabled: true,
                      myLocationTrackingMode: MyLocationTrackingMode.None,
                      onFullScreenTap: () => null, // RETHINK.TODO,
                    );
                  },
                ),
              ),
              smallColumnSpacer(),
            ],
          ),
        ),
      ),
    );
  }
}