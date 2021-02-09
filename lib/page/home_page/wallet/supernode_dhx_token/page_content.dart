import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/app_cubit.dart';
import 'package:supernodeapp/common/components/app_bars/sign_up_appbar.dart';
import 'package:supernodeapp/common/components/buttons/circle_button.dart';
import 'package:supernodeapp/common/components/loading_flash.dart';
import 'package:supernodeapp/common/components/panel/panel_frame.dart';
import 'package:supernodeapp/common/components/picker/ios_style_bottom_dailog.dart';
import 'package:supernodeapp/common/components/wallet/mining_tutorial.dart';
import 'package:supernodeapp/common/components/wallet/title_detail_row.dart';
import 'package:supernodeapp/common/utils/currencies.dart';
import 'package:supernodeapp/common/utils/screen_util.dart';
import 'package:supernodeapp/common/utils/tools.dart';
import 'package:supernodeapp/configs/images.dart';
import 'package:supernodeapp/page/home_page/bloc/supernode/dhx/cubit.dart';
import 'package:supernodeapp/page/home_page/bloc/supernode/dhx/state.dart';
import 'package:supernodeapp/page/home_page/bloc/supernode/gateway/cubit.dart';
import 'package:supernodeapp/page/home_page/bloc/supernode/gateway/state.dart';
import 'package:supernodeapp/page/home_page/wallet/token_card.dart';
import 'transactions_history.dart';
import 'mining_income.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/font.dart';
import 'package:supernodeapp/theme/spacing.dart';

class SupernodeDhxTokenPageContent extends StatefulWidget {
  const SupernodeDhxTokenPageContent({Key key}) : super(key: key);

  @override
  _SupernodeDhxTokenPageContentState createState() =>
      _SupernodeDhxTokenPageContentState();
}

class _SupernodeDhxTokenPageContentState
    extends State<SupernodeDhxTokenPageContent>
    with AutomaticKeepAliveClientMixin {
  void _showMineDXHDialog(BuildContext context, bool isDemo) {
    showInfoDialog(
      context,
      IosStyleBottomDialog2(
        builder: (ctx) => Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Text(
                FlutterI18n.translate(context, 'mining'),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: s(16),
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Divider(color: Colors.grey),
            GestureDetector(
                onTap: () {
                  Navigator.of(ctx).pop();

                  Navigator.pushNamed(context, 'lock_page',
                      arguments: {'isDemo': isDemo});

                  Navigator.push(context, MaterialPageRoute<void>(
                    builder: (BuildContext context) {
                      return Scaffold(
                        appBar: AppBars.backArrowSkipAppBar(
                            onPress: () => Navigator.pop(context),
                            action: FlutterI18n.translate(context, "skip")),
                        body: MiningTutorial(context),
                      );
                    },
                  ));
                },
                child: Row(
                  children: [
                    CircleButton(
                        icon: Image.asset(AppImages.iconMine,
                            color: Token.supernodeDhx.color)),
                    SizedBox(width: s(10)),
                    Text(
                      FlutterI18n.translate(context, 'new_mining'),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: s(16),
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                )),
            Divider(color: Colors.grey),
            GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Row(
                  children: [
                    CircleButton(
                        icon: Icon(Icons.arrow_back, color: Colors.grey)),
                    SizedBox(width: s(10)),
                    Text(
                      FlutterI18n.translate(context, 'unlock'),
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: s(16),
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                )),
            Divider(color: Colors.grey),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
      child: ListView(
        padding: EdgeInsets.only(bottom: 20),
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Row(
              children: [
                CircleButton(
                  icon: Icon(
                    Icons.add,
                    color: Colors.grey,
                  ),
                  label: FlutterI18n.translate(context, 'deposit'),
                  onTap: () {},
                ),
                Spacer(),
                CircleButton(
                  icon: Icon(
                    Icons.arrow_forward,
                    color: Colors.grey,
                  ),
                  label: FlutterI18n.translate(context, 'withdraw'),
                  onTap: () {},
                ),
                Spacer(),
                CircleButton(
                  icon: Image.asset(
                    AppImages.iconMine,
                    color: Token.supernodeDhx.color,
                  ),
                  label: FlutterI18n.translate(context, 'mine'),
                  onTap: () => _showMineDXHDialog(
                      context, context.read<AppCubit>().state.isDemo),
                ),
                Spacer(),
                BlocBuilder<SupernodeDhxCubit, SupernodeDhxState>(
                  builder: (ctx, state) => CircleButton(
                      icon: Image.asset(
                        AppImages.iconCouncil,
                        color: (state.stakes.loading ||
                                state.stakes.value == null ||
                                state.stakes.value.isEmpty)
                            ? Colors.grey
                            : Token.supernodeDhx.color,
                      ),
                      label: FlutterI18n.translate(context, 'council'),
                      onTap: () {
                        final stakes =
                            context.read<SupernodeDhxCubit>().state.stakes;
                        if (stakes.loading ||
                            stakes.value == null ||
                            stakes.value.isEmpty) return;

                        Set<String> argJoinedCouncils = state.stakes.value
                            .where((e) => !e.closed)
                            .map((e) => e.councilId)
                            .toSet();

                        Navigator.pushNamed(
                          context,
                          'list_councils_page',
                          arguments: {
                            'isDemo': context.read<AppCubit>().state.isDemo,
                            'joinedCouncilsId': argJoinedCouncils,
                          },
                        );
                      }),
                ),
              ],
            ),
          ),
          SupernodeDhxTokenCard(isExpanded: true),
          DhxMiningCard(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: CupertinoSlidingSegmentedControl(
                groupValue: selectedTab,
                onValueChanged: (tabIndex) =>
                    setState(() => selectedTab = tabIndex),
                thumbColor: Token.supernodeDhx.color,
                children: <int, Widget>{
                  0: Text(
                    FlutterI18n.translate(context, 'mining_income'),
                    style: TextStyle(
                      color: (selectedTab == 0) ? Colors.white : Colors.grey,
                    ),
                  ),
                  1: Text(
                    FlutterI18n.translate(context, 'stake_assets'),
                    style: TextStyle(
                      color: (selectedTab == 1) ? Colors.white : Colors.grey,
                    ),
                  )
                }),
          ),
          if (selectedTab == 1)
            TransactionsHistoryContent()
          else
            MiningIncomeContent(),
        ],
      ),
    );
  }
}

class DhxMiningCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PanelFrame(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children: [
            SizedBox(height: s(5)),
            Container(
              padding: kRoundRow15_5,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(FlutterI18n.translate(context, "mining"),
                      style: kBigBoldFontOfBlack),
                  Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                          FlutterI18n.translate(
                            context,
                            "daily_mining_capacity",
                          ),
                          style: kSmallFontOfBlack),
                      SizedBox(height: s(5)),
                      Text('5000 DHX',
                          style: MiddleFontOfColor(
                              color: Token.supernodeDhx.color)),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: s(20)),
            Row(
              children: [
                Spacer(),
                BlocBuilder<GatewayCubit, GatewayState>(
                  buildWhen: (a, b) => a.gatewaysTotal != b.gatewaysTotal,
                  builder: (ctx, state) => Column(
                    children: [
                      Text('${state.gatewaysTotal.value}',
                          style: kSuperBigBoldFont),
                      SizedBox(height: s(5)),
                      Container(
                        decoration: BoxDecoration(
                            color: Token.supernodeDhx.color,
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 4.0),
                          child: Text(
                            FlutterI18n.translate(context, 'm2pro_miner'),
                            style: kSecondaryButtonOfWhite,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Spacer(),
                BlocBuilder<SupernodeDhxCubit, SupernodeDhxState>(
                  buildWhen: (a, b) =>
                      a.currentMiningPower != b.currentMiningPower,
                  builder: (ctx, state) => Column(
                    children: [
                      state.currentMiningPower.loading
                          ? loadingFlash(
                              child: Text(
                                Tools.numberRounded(
                                  state.currentMiningPower.value,
                                ),
                                style: kPrimaryBigFontOfBlack,
                              ),
                            )
                          : Text(
                              Tools.numberRounded(
                                state.currentMiningPower.value,
                              ),
                              style: kSuperBigBoldFont,
                            ),
                      SizedBox(height: s(5)),
                      Container(
                        decoration: BoxDecoration(
                            color: Token.supernodeDhx.color,
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 4.0),
                          child: Stack(
                            alignment: AlignmentDirectional.center,
                            children: [
                              Text(
                                FlutterI18n.translate(context, 'm2pro_miner'),
                                style: TextStyle(
                                  color: Token.supernodeDhx.color,
                                  fontFamily: "Roboto",
                                  fontSize: 14,
                                ),
                              ), // invisible - sets width for Container
                              Text(
                                FlutterI18n.translate(context, 'mpower'),
                                style: kSecondaryButtonOfWhite,
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Spacer()
              ],
            ),
            SizedBox(
              height: s(10),
            ),
            TitleDetailRow(
              name:
                  FlutterI18n.translate(context, 'estimated_dxh_daily_return'),
              value: FlutterI18n.translate(context, 'coming'),
              token: "",
              disabled: true,
            ),
            BlocBuilder<SupernodeDhxCubit, SupernodeDhxState>(
              buildWhen: (a, b) => a.lastMiningPower != b.lastMiningPower,
              builder: (ctx, state) => TitleDetailRow(
                loading: state.lastMiningPower.loading,
                name: FlutterI18n.translate(context, 'supernode_mining_power'),
                value: Tools.numberRounded(state.lastMiningPower.value),
                token: "mPower",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
