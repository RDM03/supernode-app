import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:pagination_view/pagination_view.dart';
import 'package:supernodeapp/app_cubit.dart';
import 'package:supernodeapp/common/components/app_bars/home_bar.dart';
import 'package:supernodeapp/common/components/dialog/full_screen_dialog.dart';
import 'package:supernodeapp/common/components/empty.dart';
import 'package:supernodeapp/common/components/loading_list.dart';
import 'package:supernodeapp/common/components/page/page_body.dart';
import 'package:supernodeapp/common/components/panel/panel_body.dart';
import 'package:supernodeapp/common/components/panel/panel_frame.dart';
import 'package:supernodeapp/common/components/picker/ios_style_bottom_dailog.dart';
import 'package:supernodeapp/common/utils/time.dart';
import 'package:supernodeapp/common/utils/tools.dart';
import 'package:supernodeapp/page/home_page/bloc/supernode/gateway/cubit.dart';
import 'package:supernodeapp/page/home_page/bloc/supernode/gateway/state.dart';
import 'package:supernodeapp/page/home_page/bloc/supernode/user/cubit.dart';
import 'package:supernodeapp/page/home_page/bloc/supernode/user/state.dart';
import 'package:supernodeapp/theme/font.dart';
import 'package:supernodeapp/theme/spacing.dart';

import '../shared.dart';

class GatewayTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: homeBar(
        FlutterI18n.translate(context, 'gateway'),
        onPressed: () => openSettings(context),
      ),
      body: RefreshIndicator(
        displacement: 10,
        onRefresh: () async {
          context.read<GatewayCubit>().refresh();
          await Future.delayed(Duration(seconds: 2));
        },
        child: PageBody(
          useColumn: true,
          children: [
            BlocBuilder<GatewayCubit, GatewayState>(
              buildWhen: (a, b) => a.gatewaysTotal != b.gatewaysTotal,
              builder: (ctx, gatewayState) =>
                  BlocBuilder<SupernodeUserCubit, SupernodeUserState>(
                buildWhen: (a, b) =>
                    a.gatewaysRevenueUsd != b.gatewaysRevenueUsd ||
                    a.gatewaysRevenue != b.gatewaysRevenue,
                builder: (ctx, state) => PanelFrame(
                  child: PanelBody(
                    keyIcon: ValueKey('minersAddIcon'),
                    keyTitle: ValueKey('totalMinersTitle'),
                    keySubtitle: ValueKey('totalMinersSubtitle'),
                    keyTrailSubtitle: ValueKey('minersRevenue'),
                    loading: gatewayState.gatewaysTotal.loading,
                    icon: Icons.add_circle,
                    onPressed: () async {
                      if (!context
                          .read<SupernodeCubit>()
                          .state
                          .session
                          .isDemo) {
                        await Navigator.of(context)
                            .pushNamed('add_gateway_page', arguments: {
                          'fromPage': 'home',
                        });
                        await context.read<GatewayCubit>().refreshGateways();
                      }
                    },
                    titleText: FlutterI18n.translate(context, 'total_gateways'),
                    subtitleText: '${gatewayState.gatewaysTotal.value}',
                    trailTitle: FlutterI18n.translate(context, 'profit'),
                    trailLoading: state.gatewaysRevenue.loading,
                    trailSubtitle:
                        '${Tools.priceFormat(state.gatewaysRevenue.value)} MXC (${Tools.priceFormat(state.gatewaysRevenueUsd.value)} USD)',
                  ),
                ),
              ),
            ),
            BlocBuilder<GatewayCubit, GatewayState>(
              buildWhen: (a, b) => a.gateways != b.gateways,
              builder: (ctx, state) => Container(
                height: 120.0 * (state.gatewaysTotal.value ?? 0),
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height - 305,
                ),
                child: PanelFrame(
                  child: state.gateways.loading
                      ? LoadingList()
                      : (state.gateways.value?.length != 0
                          ? Padding(
                              padding: kOuterRowTop10,
                              child: GatewaysList(
                                state: state,
                              ),
                            )
                          : Empty()),
                ),
              ),
            ),
            SizedBox(height: 20)
          ],
        ),
      ),
    );
  }
}

class GatewaysList extends StatelessWidget {
  final GatewayState state;

  const GatewaysList({Key key, this.state}) : super(key: key);

  void showDeleteDialog(BuildContext context, String gatewayId) {
    final list = [
      IosButtonStyle(
        title: FlutterI18n.translate(context, 'confirm_deleting_miner_title'),
        style: kBigFontOfBlack.copyWith(fontWeight: FontWeight.w600),
      ),
      IosButtonStyle(
        title: FlutterI18n.translate(context, 'confirm_deleting_miner_message'),
      ),
      IosButtonStyle(
        title: FlutterI18n.translate(context, 'delete_miner'),
        style: kBigFontOfBlack.copyWith(color: Colors.red),
      ),
    ];

    showDialog(
      context: context,
      builder: (BuildContext ctx) => FullScreenDialog(
        child: IosStyleBottomDialog(
          blueActionIndex: 0,
          list: list,
          onItemClickListener: (itemIndex) {
            if (itemIndex == 2)
              context.read<GatewayCubit>().deleteGateway(gatewayId);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PaginationView<GatewayItem>(
      itemBuilder: (BuildContext context, GatewayItem state, int index) =>
          Slidable(
        key: Key("slide_gateway$index"),
        actionPane: SlidableDrawerActionPane(), //SlidableBehindActionPane
        actionExtentRatio: 0.25,
        child: GatewayListTile(
          state: state,
          onTap: () async {
            await Navigator.pushNamed(context, 'gateway_profile_page',
                arguments: {
                  'item': state,
                  'isDemo': context.read<SupernodeCubit>().state.session.isDemo,
                });
          },
        ),
        secondaryActions: <Widget>[
          IconSlideAction(
            key: ValueKey("delete_gateway_button$index"),
            caption: FlutterI18n.translate(context, 'delete'),
            color: Colors.red,
            icon: Icons.delete,
            onTap: () => showDeleteDialog(context, state.id),
          )
        ],
      ),
      pageFetch: (page) async {
        if (page == 0) return state.gateways.value;
        return await context.read<GatewayCubit>().loadNextPage(page);
      },
      onError: (dynamic error) => Center(
        child: Text('Some error occured'),
      ),
      onEmpty: Empty(),
    );
  }
}

class GatewayListTile extends StatelessWidget {
  final VoidCallback onTap;
  final GatewayItem state;

  GatewayListTile({
    @required this.onTap,
    @required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: const EdgeInsets.only(bottom: 2),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Color.fromARGB(26, 0, 0, 0), width: 1),
        ),
      ),
      child: ListTile(
        tileColor: Colors.white,
        onTap: onTap,
        title: Row(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 90,
                  padding: kOuterRowTop10,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 5, top: 4),
                        child: Icon(
                          Icons.lens,
                          color: TimeUtil.isIn5Min(state.lastSeenAt)
                              ? Colors.green
                              : Colors.grey,
                          size: 10,
                        ),
                      ),
                      Text(
                        TimeUtil.isIn5Min(state.lastSeenAt)
                            ? '(${FlutterI18n.translate(context, 'online')})'
                            : '(${FlutterI18n.translate(context, 'offline')})',
                        style: kSmallFontOfGrey,
                      ),
                    ],
                  ),
                ),
                Padding(
                    padding: kOuterRowTop5,
                    child: Text(state.name,
                        textAlign: TextAlign.left, style: kBigFontOfBlack)),
                Padding(
                  padding: kOuterRowTop5,
                  child: Text(
                    '${FlutterI18n.translate(context, 'last_seen')}: ${TimeUtil.getDatetime(state.lastSeenAt)}',
                    style: kSmallFontOfGrey,
                  ),
                )
              ],
            ),
            Spacer(),
            Container(
              alignment: Alignment.centerRight,
              margin: kOuterRowTop20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(
                    '${FlutterI18n.translate(context, 'downlink_price')}',
                    style: kSmallFontOfGrey,
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 5),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(51, 77, 137, 229),
                      borderRadius: BorderRadius.all(Radius.circular(7)),
                    ),
                    child: Text(
                      '${state.location["accuracy"]} MXC',
                      style: kBigFontOfBlack,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
