import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/column_spacer.dart';
import 'package:supernodeapp/common/components/loading_flash.dart';
import 'package:supernodeapp/common/components/panel/panel_frame.dart';
import 'package:supernodeapp/common/components/wallet/title_detail_row.dart';
import 'package:supernodeapp/common/utils/currencies.dart';
import 'package:supernodeapp/common/utils/screen_util.dart';
import 'package:supernodeapp/common/utils/tools.dart';
import 'package:supernodeapp/page/home_page/bloc/supernode/dhx/cubit.dart';
import 'package:supernodeapp/page/home_page/bloc/supernode/dhx/state.dart';
import 'package:supernodeapp/page/home_page/bloc/supernode/gateway/cubit.dart';
import 'package:supernodeapp/page/home_page/bloc/supernode/gateway/state.dart';
import 'package:supernodeapp/page/home_page/shared.dart';
import 'package:supernodeapp/page/home_page/wallet/supernode_dhx_token/actions.dart';
import 'package:supernodeapp/page/home_page/wallet/token_card.dart';
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
            padding: const EdgeInsets.only(top: 30, bottom: 10),
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
                    FlutterI18n.translate(context, 'bonding_history'),
                    key: Key('bondingHistoryText'),
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
                key: Key('boostMpowerTap'),
                onTap: () => showBoostMPowerDialog(context),
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
                  name: FlutterI18n.translate(
                      context, 'estimated_dxh_daily_return'),
                  value: '5000.00',
                  token: Token.supernodeDhx.name,
                ),
                BlocBuilder<SupernodeDhxCubit, SupernodeDhxState>(
                  buildWhen: (a, b) =>
                      a.yesterdayTotalMPower != b.yesterdayTotalMPower,
                  builder: (ctx, state) => TitleDetailRow(
                    loading: state.yesterdayTotalMPower.loading,
                    name: FlutterI18n.translate(
                        context, 'supernode_mining_power'),
                    value:
                        Tools.numberRounded(state.yesterdayTotalMPower.value),
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
              Text('${state.gatewaysTotal.value}', style: kSuperBigBoldFont),
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
          buildWhen: (a, b) => a.currentMiningPower != b.currentMiningPower,
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
