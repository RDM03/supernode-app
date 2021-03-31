import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/app_cubit.dart';
import 'package:supernodeapp/common/components/app_bars/sign_up_appbar.dart';
import 'package:supernodeapp/common/components/buttons/circle_button.dart';
import 'package:supernodeapp/common/components/column_spacer.dart';
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
import 'package:supernodeapp/page/home_page/bloc/supernode/user/cubit.dart';
import 'package:supernodeapp/page/home_page/wallet/supernode_dhx_token/actions.dart';
import 'package:supernodeapp/page/home_page/wallet/token_card.dart';
import 'package:url_launcher/url_launcher.dart';
import 'transactions_history.dart';
import 'mining_income.dart';
import 'package:supernodeapp/theme/font.dart';

class SupernodeDhxTokenPageContent extends StatefulWidget {
  const SupernodeDhxTokenPageContent({Key key}) : super(key: key);

  @override
  _SupernodeDhxTokenPageContentState createState() =>
      _SupernodeDhxTokenPageContentState();
}

class _SupernodeDhxTokenPageContentState
    extends State<SupernodeDhxTokenPageContent>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: ListView(
        padding: EdgeInsets.only(bottom: 20),
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: SupernodeDhxActions(),
          ),
          SupernodeDhxTokenCard(),
          DhxMiningCard(),
          Padding(
            child: CupertinoSlidingSegmentedControl(
            padding: const EdgeInsets.only(top: 30, bottom: 10),
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

  void showBoostDialog(BuildContext ctx) {
    showInfoDialog(
      ctx,
      IosStyleBottomDialog2(
        builder: (context) => Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Text(
                FlutterI18n.translate(context, 'boost_mpower'),
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
                Navigator.pop(context);
                launch('https://www.matchx.io/product/m2-pro-lpwan-crypto-miner/');
              },
              child: Row(
                children: [
                  CircleButton(
                    icon: Icon(Icons.shopping_basket, color: Token.supernodeDhx.color),
                  ),
                  SizedBox(
                    width: s(10),
                  ),
                  Text(
                    FlutterI18n.translate(context, 'shop_m2pro'),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: s(16),
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Divider(color: Colors.grey),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              /*onTap: () {
                Navigator.pop(context);
                openSupernodeStake(ctx);
              },*/
              onTap: () {
                Navigator.pop(context);
                Navigator.of(ctx).pushNamed('lock_page', arguments: {
                  'balance': ctx.read<SupernodeUserCubit>().state.balance.value,
                  'isDemo': ctx.read<AppCubit>().state.isDemo,
                });
              },
              child: Row(
                children: [
                  CircleButton(
                    icon: Icon(
                      Icons.lock,
                      color: Token.supernodeDhx.color,
                    ),
                  ),
                  SizedBox(
                    width: s(10),
                  ),
                  Text(
                    FlutterI18n.translate(context, 'lock_mxc'),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: s(16),
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Divider(color: Colors.grey),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                Navigator.pop(context);
                Navigator.push(ctx, MaterialPageRoute<void>(
                  builder: (BuildContext context) {
                    return Scaffold(
                      appBar: AppBars.backArrowSkipAppBar(
                          title: FlutterI18n.translate(context, 'tutorial_title'),
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
                    icon: Image.asset(
                      AppImages.iconLearn,
                      color: Token.supernodeDhx.color,
                    ),
                  ),
                  SizedBox(
                    width: s(10),
                  ),
                  Text(
                    FlutterI18n.translate(context, 'learn_more'),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: s(16),
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Divider(color: Colors.grey),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(top: 30, bottom: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(FlutterI18n.translate(context, "mining_ability"),
                  style: kBigBoldFontOfBlack),
              Spacer(),
              GestureDetector(
                onTap: () => showBoostDialog(context),
                child: Container(
                  decoration: BoxDecoration(
                      color: Token.supernodeDhx.color.withOpacity(.2),
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 4.0),
                    child: Text(
                      '+ ${FlutterI18n.translate(context, 'boost_mpower')}',
                      style: MiddleFontOfColor(color: Token.supernodeDhx.color),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        PanelFrame(
          rowTop: EdgeInsets.all(0),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Column(
              children: [
                SizedBox(height: s(5)),
                NumberMinersAndMPower(),
                smallColumnSpacer(),
                TitleDetailRow(
                  name:
                      FlutterI18n.translate(context, 'estimated_dxh_daily_return'),
                  value: '5000.00',
                  token: Token.supernodeDhx.name,
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
        ),
      ],
    );
  }
}

class NumberMinersAndMPower extends StatelessWidget {
  const NumberMinersAndMPower({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}
