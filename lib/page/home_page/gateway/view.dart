import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:pagination_view/pagination_view.dart';
import 'package:supernodeapp/app_cubit.dart';
import 'package:supernodeapp/common/components/app_bars/home_bar.dart';
import 'package:supernodeapp/common/components/buttons/circle_button.dart';
import 'package:supernodeapp/common/components/buttons/primary_button.dart';
import 'package:supernodeapp/common/components/column_spacer.dart';
import 'package:supernodeapp/common/components/dialog/full_screen_dialog.dart';
import 'package:supernodeapp/common/components/empty.dart';
import 'package:supernodeapp/common/components/loading_flash.dart';
import 'package:supernodeapp/common/components/loading_list.dart';
import 'package:supernodeapp/common/components/page/page_frame.dart';
import 'package:supernodeapp/common/components/panel/panel_frame.dart';
import 'package:supernodeapp/common/components/picker/ios_style_bottom_dailog.dart';
import 'package:supernodeapp/common/components/row_spacer.dart';
import 'package:supernodeapp/common/components/widgets/circular_graph.dart';
import 'package:supernodeapp/common/utils/time.dart';
import 'package:supernodeapp/common/utils/tools.dart';
import 'package:supernodeapp/configs/images.dart';
import 'package:supernodeapp/page/add_fuel_page/add_fuel_page.dart';
import 'package:supernodeapp/page/home_page/bloc/supernode/gateway/cubit.dart';
import 'package:supernodeapp/page/home_page/bloc/supernode/gateway/state.dart';
import 'package:supernodeapp/page/home_page/bloc/supernode/user/cubit.dart';
import 'package:supernodeapp/page/home_page/bloc/supernode/user/state.dart';
import 'package:supernodeapp/page/miner_detail_page/miner_detail_page.dart';
import 'package:supernodeapp/page/send_to_wallet_page/send_to_wallet_page.dart';
import 'package:supernodeapp/route.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/font.dart';
import 'package:supernodeapp/theme/spacing.dart';

import '../shared.dart';

class GatewayTab extends StatelessWidget {
  void aboutPage(
      BuildContext context, String title, Widget illustration, String text,
      {Widget bottomButton}) {
    Navigator.of(context).push(MaterialPageRoute(
        fullscreenDialog: true,
        builder: (ctx) => pageFrame(
                context: ctx,
                padding: EdgeInsets.all(0.0),
                children: <Widget>[
                  ListTile(
                    title:
                        Center(child: Text(title, style: kBigBoldFontOfBlack)),
                    leading: SizedBox(),
                    trailing: GestureDetector(
                      child: Icon(Icons.close, color: Colors.black),
                      onTap: () => Navigator.of(ctx).pop(),
                    ),
                  ),
                  SizedBox(height: 50),
                  Center(child: illustration),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(text,
                        style: kBigFontOfBlack, textAlign: TextAlign.center),
                  ),
                  SizedBox(height: 70),
                  (bottomButton != null)
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: bottomButton)
                      : SizedBox(),
                ])));
  }

  Widget aboutPageIllustration(String title, Widget image) {
    return Container(
      height: 150,
      width: 150,
      decoration: BoxDecoration(
        color: minerColor.withOpacity(.1),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('100%', style: kVeryBigFontOfBlack),
              SizedBox(height: 5),
              image,
              SizedBox(height: 5),
              Text(title, style: kBigFontOfBlack),
            ]),
      ),
    );
  }

  void addSendDialog(BuildContext ctx) {
    showInfoDialog(
      ctx,
      IosStyleBottomDialog2(
        padding: EdgeInsets.only(top: 10, bottom: 30),
        builder: (context) => Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16, bottom: 16, left: 32),
              child: SizedBox(
                width: double.infinity,
                child: Text(
                  FlutterI18n.translate(context, 'add_fuel_or_send_to_wallet'),
                  style: kBigBoldFontOfBlack,
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            Divider(),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () async {
                Navigator.pop(context);
                await Navigator.of(ctx).push(route((ctx) => AddFuelPage()));
                await context.read<GatewayCubit>().refresh();
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 32),
                child: Row(mainAxisSize: MainAxisSize.max, children: [
                  CircleButton(
                    key: Key('addFuelBottom'),
                    circleColor: Colors.white,
                    icon: Image.asset(
                      AppImages.fuel,
                      color: fuelColor,
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    FlutterI18n.translate(context, 'add_fuel'),
                    style: kBigFontOfBlack,
                    textAlign: TextAlign.left,
                  ),
                ]),
              ),
            ),
            Divider(),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () async {
                Navigator.pop(context);
                await Navigator.of(ctx)
                    .push(route((ctx) => SendToWalletPage()));
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 32),
                child: Row(mainAxisSize: MainAxisSize.max, children: [
                  CircleButton(
                    key: Key('addFuelBottom'),
                    circleColor: Colors.white,
                    icon: Icon(Icons.arrow_forward, color: fuelColor),
                  ),
                  SizedBox(width: 10),
                  Text(
                    FlutterI18n.translate(context, 'send_to_wallet'),
                    style: kBigFontOfBlack,
                    textAlign: TextAlign.left,
                  ),
                ]),
              ),
            ),
            Divider(),
          ],
        ),
      ),
    );
  }

  Widget minerHealthDashboard(BuildContext context) {
    Color disabledColor = Color.fromARGB(255, 152, 166,
        173); //remove once all health info implemented as well as disabled image assets
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BlocBuilder<GatewayCubit, GatewayState>(
            buildWhen: (a, b) =>
                (a.gatewaysTotal != b.gatewaysTotal || a.health != b.health),
            builder: (ctx, gatewayState) =>
                BlocBuilder<SupernodeUserCubit, SupernodeUserState>(
                  buildWhen: (a, b) =>
                      a.gatewaysRevenueUsd != b.gatewaysRevenueUsd ||
                      a.gatewaysRevenue != b.gatewaysRevenue,
                  builder: (ctx, state) => PanelFrame(
                      rowTop: EdgeInsets.only(top: 0),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(children: [
                          Stack(
                            alignment: Alignment.topCenter,
                            children: [
                              Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CircleButton(
                                      key: Key('addMiner'),
                                      circleColor: minerColor,
                                      icon: Image.asset(
                                        AppImages.gateways,
                                        color: Colors.white,
                                      ),
                                      label:
                                          FlutterI18n.translate(context, 'add'),
                                      onTap: () async {
                                        if (!context
                                            .read<AppCubit>()
                                            .state
                                            .isDemo) {
                                          await openSupernodeMiner(context,
                                              hasSkip: false);
                                          await context
                                              .read<GatewayCubit>()
                                              .refreshGateways();
                                        }
                                      },
                                    ),
                                    Spacer(),
                                    CircleButton(
                                      key: Key('addFuel'),
                                      circleColor: fuelColor,
                                      icon: Image.asset(
                                        AppImages.fuel,
                                        color: Colors.white,
                                      ),
                                      label: FlutterI18n.translate(
                                          context, 'add_send'),
                                      onTap: () => addSendDialog(context),
                                    ),
                                  ]),
                              Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: GestureDetector(
                                  onTap: () => aboutPage(
                                      ctx,
                                      FlutterI18n.translate(
                                          context, 'health_score'),
                                      CircularGraph(90, minerColor,
                                          child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text('90 %',
                                                    style: kSuperBigBoldFont),
                                                Text(
                                                    FlutterI18n.translate(
                                                        context,
                                                        'health_score'),
                                                    style: kMiddleFontOfGrey),
                                              ])),
                                      FlutterI18n.translate(
                                          context, 'health_score_info')),
                                  child: CircularGraph(
                                      gatewayState.health.loading
                                          ? 0.0
                                          : (gatewayState.health.value ?? 0.0) *
                                              100,
                                      (gatewayState.health.loading ||
                                              (gatewayState.health.value ?? 0) *
                                                      100 >
                                                  10)
                                          ? minerColor
                                          : fuelColor,
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            loadableWidget(
                                                loading:
                                                    gatewayState.health.loading,
                                                child: (gatewayState
                                                            .health.value ==
                                                        null)
                                                    ? Text('-- %',
                                                        style:
                                                            kSuperBigBoldFont)
                                                    : Text(
                                                        '${Tools.priceFormat(gatewayState.health.value * 100)} %',
                                                        style:
                                                            kSuperBigBoldFont)),
                                            Text(
                                                FlutterI18n.translate(
                                                    context, 'health_score'),
                                                style: kMiddleFontOfGrey),
                                          ])),
                                ),
                              ),
                            ],
                          ),
                          middleColumnSpacer(),
                          loadableWidget(
                              loading: state.gatewaysRevenue.loading,
                              child: (state.gatewaysRevenue.value == null)
                                  ? Text('-- MXC', style: kSuperBigBoldFont)
                                  : Text(
                                      '${Tools.priceFormat(state.gatewaysRevenue.value)} MXC',
                                      style: kSuperBigBoldFont)),
                          Text(
                              FlutterI18n.translate(
                                  context, 'total_mining_revenue'),
                              style: kMiddleFontOfGrey),
                          middleColumnSpacer(),
                          Row(children: [
                            Spacer(),
                            Image.asset(
                              AppImages.gateways,
                              scale: 1.5,
                              color: minerColor,
                            ),
                            smallRowSpacer(),
                            loadableWidget(
                                loading: gatewayState.gatewaysTotal.loading,
                                child: (gatewayState.gatewaysTotal.value ==
                                        null)
                                    ? Text(
                                        '-- ${FlutterI18n.translate(context, 'miners')}')
                                    : Text(
                                        '${gatewayState.gatewaysTotal.value} ${FlutterI18n.translate(context, 'miners')}')),
                            smallRowSpacer(),
                            Image.asset(
                              AppImages.fuel,
                              scale: 1.5,
                              color: fuelColor,
                            ),
                            smallRowSpacer(),
                            loadableWidget(
                                loading: gatewayState.miningFuel.loading,
                                child: (gatewayState.miningFuel.value == null)
                                    ? Text('-- / -- MXC')
                                    : Text(
                                        '${gatewayState.miningFuel.value.round()} / ${gatewayState.miningFuelMax.value.round()} MXC')),
                            Spacer()
                          ]),
                          middleColumnSpacer(),
                          Row(children: [
                            Expanded(
                              flex: 1,
                              child: GestureDetector(
                                onTap: () => aboutPage(
                                    ctx,
                                    FlutterI18n.translate(context, 'uptime'),
                                    aboutPageIllustration(
                                        FlutterI18n.translate(
                                            context, 'uptime'),
                                        Image.asset(AppImages.uptime,
                                            scale: 0.7)),
                                    FlutterI18n.translate(
                                        context, 'uptime_info')),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: minerColor.withOpacity(.1),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          loadableWidget(
                                              loading: gatewayState
                                                  .uptimeHealth.loading,
                                              child: (gatewayState
                                                          .uptimeHealth.value ==
                                                      null)
                                                  ? Text('-- %',
                                                      style:
                                                          kBigBoldFontOfBlack)
                                                  : Text(
                                                      '${Tools.priceFormat(gatewayState.uptimeHealth.value * 100)} %',
                                                      style:
                                                          kBigBoldFontOfBlack)),
                                          Image.asset(AppImages.uptime),
                                          Text(
                                              FlutterI18n.translate(
                                                  context, 'uptime'),
                                              style: kSmallBoldFontOfBlack),
                                        ]),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              flex: 1,
                              child: GestureDetector(
                                onTap: () => aboutPage(
                                    ctx,
                                    FlutterI18n.translate(context, 'gps'),
                                    aboutPageIllustration(
                                        FlutterI18n.translate(context, 'gps'),
                                        Image.asset(AppImages.gps, scale: 0.7)),
                                    FlutterI18n.translate(context, 'gps_info')),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: disabledColor.withOpacity(.2),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text('-', style: kBigFontOfGrey),
                                          Image.asset(AppImages.gps_disabled),
                                          Text(
                                              FlutterI18n.translate(
                                                  context, 'gps'),
                                              style: kSmallFontOfGrey),
                                        ]),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              flex: 1,
                              child: GestureDetector(
                                onTap: () => aboutPage(
                                    ctx,
                                    FlutterI18n.translate(context, 'altitude'),
                                    aboutPageIllustration(
                                        FlutterI18n.translate(
                                            context, 'altitude'),
                                        Image.asset(AppImages.altitude,
                                            scale: 0.7)),
                                    FlutterI18n.translate(
                                        context, 'altitude_info')),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: disabledColor.withOpacity(.2),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text('-', style: kBigFontOfGrey),
                                          Image.asset(
                                              AppImages.altitude_disabled),
                                          Text(
                                              FlutterI18n.translate(
                                                  context, 'altitude'),
                                              style: kSmallFontOfGrey),
                                        ]),
                                  ),
                                ),
                              ),
                            ),
                          ]),
                          SizedBox(height: 10),
                          Row(children: [
                            Expanded(
                              flex: 1,
                              child: GestureDetector(
                                onTap: () => aboutPage(
                                    ctx,
                                    FlutterI18n.translate(
                                        context, 'orientation'),
                                    aboutPageIllustration(
                                        FlutterI18n.translate(
                                            context, 'orientation'),
                                        Image.asset(AppImages.orientation,
                                            scale: 0.7)),
                                    FlutterI18n.translate(
                                        context, 'orientation_info')),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: disabledColor.withOpacity(.2),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text('-', style: kBigFontOfGrey),
                                          Image.asset(
                                              AppImages.orientation_disabled),
                                          Text(
                                              FlutterI18n.translate(
                                                  context, 'orientation'),
                                              style: kSmallFontOfGrey),
                                        ]),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              flex: 1,
                              child: GestureDetector(
                                onTap: () => aboutPage(
                                    ctx,
                                    FlutterI18n.translate(context, 'proximity'),
                                    aboutPageIllustration(
                                        FlutterI18n.translate(
                                            context, 'proximity'),
                                        Image.asset(AppImages.proximity,
                                            scale: 0.7)),
                                    FlutterI18n.translate(
                                        context, 'proximity_info')),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: disabledColor.withOpacity(.2),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text('-', style: kBigFontOfGrey),
                                          Image.asset(
                                              AppImages.proximity_disabled),
                                          Text(
                                              FlutterI18n.translate(
                                                  context, 'proximity'),
                                              style: kSmallFontOfGrey),
                                        ]),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              flex: 1,
                              child: GestureDetector(
                                onTap: () => aboutPage(
                                    ctx,
                                    FlutterI18n.translate(context, 'fuel'),
                                    aboutPageIllustration(
                                        FlutterI18n.translate(context, 'fuel'),
                                        Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              Image.asset(AppImages.uptime,
                                                  color: Colors.white,
                                                  scale: 0.7),
                                              Image.asset(AppImages.fuel,
                                                  color: fuelColor, scale: 0.7),
                                            ])),
                                    FlutterI18n.translate(context, 'fuel_info'),
                                    bottomButton: PrimaryButton(
                                        minWidth: double.infinity,
                                        minHeight: 40,
                                        onTap: () async {
                                          Navigator.pop(context);
                                          await Navigator.of(ctx).push(
                                              route((ctx) => AddFuelPage()));
                                        },
                                        buttonTitle: FlutterI18n.translate(
                                            context, 'fuel_miners'),
                                        bgColor: fuelColor)),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: minerColor.withOpacity(.1),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          loadableWidget(
                                              loading: gatewayState
                                                  .miningFuelHealth.loading,
                                              child: (gatewayState
                                                          .miningFuelHealth
                                                          .value ==
                                                      null)
                                                  ? Text('-- %',
                                                      style:
                                                          kBigBoldFontOfBlack)
                                                  : Text(
                                                      '${Tools.priceFormat(gatewayState.miningFuelHealth.value * 100)} %',
                                                      style:
                                                          kBigBoldFontOfBlack)),
                                          Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                Image.asset(AppImages.uptime,
                                                    color: Colors.white),
                                                Image.asset(AppImages.fuel,
                                                    color: fuelColor),
                                              ]),
                                          Text(
                                              FlutterI18n.translate(
                                                  context, 'fuel'),
                                              style: kSmallBoldFontOfBlack),
                                        ]),
                                  ),
                                ),
                              ),
                            ),
                          ]),
                        ]),
                      )),
                )),
        SizedBox(height: 30),
        Text(FlutterI18n.translate(context, "list_miners"),
            style: kBigBoldFontOfBlack),
        SizedBox(height: 10),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: homeBar(
        FlutterI18n.translate(context, 'gateway'),
        onPressed: () => openSettings(context),
      ),
      backgroundColor: backgroundColor,
      body: BlocBuilder<GatewayCubit, GatewayState>(
        buildWhen: (a, b) => a.gateways != b.gateways,
        builder: (ctx, state) => Container(
          height: MediaQuery.of(context).size.height - 150,
          color: backgroundColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: state.gateways.loading
                ? LoadingList()
                : (state.gateways.value?.length != 0
                    ? RefreshIndicator(
                        displacement: 0,
                        onRefresh: () async {
                          await context.read<GatewayCubit>().refresh();
                        },
                        child: GatewaysList(
                          header: minerHealthDashboard(context),
                          state: state,
                        ),
                      )
                    : Empty()),
          ),
        ),
      ),
    );
  }
}

class GatewaysList extends StatelessWidget {
  final GatewayState state;
  final Widget header;

  const GatewaysList({Key key, this.header, this.state}) : super(key: key);

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
      header: header,
      itemBuilder: (BuildContext context, GatewayItem state, int index) =>
          Slidable(
        key: Key("slide_gateway$index"),
        actionPane: SlidableDrawerActionPane(),
        actionExtentRatio: 0.25,
        child: GatewayListTile(
          state: state,
          topOfList: index == 0,
          onTap: () async {
            if (!state.reseller)
              await Navigator.push(
                context,
                MaterialPageRoute(
                  fullscreenDialog: true,
                  builder:(ctx) => MinerDetailPage(
                    item: state,
                  ),
                )
              );
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
      separatorBuilder: (BuildContext context, int index) =>
          Divider(height: 1, thickness: 1, color: Colors.grey.shade50),
      footer: Container(
        height: 10,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: shodowColor,
              offset: Offset(0, 2),
              blurRadius: 7,
            ),
          ],
        ),
        child: SizedBox(),
      ),
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
  final bool topOfList;

  GatewayListTile({
    @required this.onTap,
    @required this.state,
    @required this.topOfList,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: (topOfList ? 5 : 0)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: (topOfList)
            ? BorderRadius.vertical(top: Radius.circular(10))
            : null,
        boxShadow: [
          BoxShadow(
            color: shodowColor,
            offset: Offset(0, 2),
            blurRadius: 7,
          ),
        ],
      ),
      child: ListTile(
        tileColor: Colors.white,
        onTap: onTap,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
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
                  SizedBox(width: 5),
                  Text(
                    TimeUtil.isIn5Min(state.lastSeenAt)
                        ? '${FlutterI18n.translate(context, 'online').toUpperCase()}'
                        : '${FlutterI18n.translate(context, 'offline').toUpperCase()}',
                    style: kMiddleFontOfGrey,
                  ),
                  Spacer(),
                  (state.reseller)
                      ? SizedBox()
                      : Image.asset(
                          AppImages.gateways,
                          scale: 1.5,
                          color: minerColor,
                        ),
                  smallRowSpacer(),
                  (state.reseller)
                      ? SizedBox()
                      : Text(
                          '${Tools.priceFormat((state.health ?? 0) * 100)} %',
                          style: kBigFontOfBlack),
                  smallRowSpacer(),
                  (state.reseller)
                      ? SizedBox()
                      : Image.asset(
                          AppImages.fuel,
                          scale: 1.5,
                          color: fuelColor,
                        ),
                  smallRowSpacer(),
                  (state.reseller)
                      ? SizedBox()
                      : Text(
                          '${Tools.priceFormat((state.miningFuelHealth ?? 0) * 100)} %',
                          style: kBigFontOfBlack),
                ],
              ),
            ),
            Padding(
                padding: kOuterRowTop5,
                child: Text(state.name,
                    textAlign: TextAlign.left, style: kBigFontOfBlack)),
            Padding(
              padding: kOuterRowTop5,
              child: Row(
                children: [
                  Text(
                    '${FlutterI18n.translate(context, 'last_seen')}',
                    style: kSmallFontOfGrey,
                  ),
                  Spacer(),
                  Text(
                    '${TimeUtil.getDatetime(state.lastSeenAt)}',
                    style: kBigFontOfBlack,
                  ),
                ],
              ),
            ),
            Padding(
              padding: kOuterRowTop5,
              child: Row(
                children: [
                  Text(
                    '${FlutterI18n.translate(context, 'revenue')}',
                    style: kSmallFontOfGrey,
                  ),
                  Spacer(),
                  Text(
                    '${Tools.priceFormat(state.totalMined)} MXC',
                    style: kBigFontOfBlack,
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
