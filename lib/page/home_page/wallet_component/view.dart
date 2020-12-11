import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/app_bars/home_bar.dart';
import 'package:supernodeapp/common/components/buttons/circle_button.dart';
import 'package:supernodeapp/common/components/buttons/primary_button.dart';
import 'package:supernodeapp/common/components/empty.dart';
import 'package:supernodeapp/common/components/loading_list.dart';
import 'package:supernodeapp/common/components/page/page_body.dart';
import 'package:supernodeapp/common/components/panel/panel_frame.dart';
import 'package:supernodeapp/common/components/picker/ios_style_bottom_dailog.dart';
import 'package:supernodeapp/common/components/wallet/date_buttons.dart';
import 'package:supernodeapp/common/components/wallet/secondary_buttons.dart';
import 'package:supernodeapp/common/components/wallet/title_detail_row.dart';
import 'package:supernodeapp/common/utils/screen_util.dart';
import 'package:supernodeapp/common/utils/tools.dart';
import 'package:supernodeapp/configs/images.dart';
import 'package:supernodeapp/page/home_page/action.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/font.dart';
import 'package:supernodeapp/theme/spacing.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    WalletState state, Dispatch dispatch, ViewService viewService) {
  var _ctx = viewService.context;
  final ListAdapter adapter = viewService.buildAdapter();

  Widget tokenCard (Token tkn) => GestureDetector(
      onTap: () => dispatch(WalletActionCreator.expand(tkn)),
      child: panelFrame(
          child: Column(
            children: [
              Container(
                padding: kRoundRow205,
                child: Row(children: [
                  Image.asset((tkn == Token.MXC) ? AppImages.logoMXC : AppImages.logoDHX, height: s(50)),
                  Text((tkn == Token.MXC) ? "MXC" : "DHX"),
                  Spacer(),
                  state.expandedView
                      ? (tkn == Token.DHX)
                        ? PrimaryButton(buttonTitle: FlutterI18n.translate(_ctx, 'simulate_mining'))
                        : SizedBox()
                      : Icon(Icons.arrow_forward_ios)
                ]),
              ),
              titleDetailRow(
                loading: !state.loadingMap.contains('balance'),
                name: FlutterI18n.translate(_ctx, 'current_balance'),
                value: Tools.priceFormat((tkn == Token.MXC) ? state.balance : 7060.00),//TODO replace 7060.00
                token: (tkn == Token.MXC) ? "MXC" : "DHX"),
              (state.expandedView && tkn == Token.DHX)
              ? titleDetailRow(
                  loading: !state.loadingMap.contains('balance'),//TODO
                  name: FlutterI18n.translate(_ctx, 'locked_amount'),
                  value: Tools.priceFormat(7060.00),//TODO replace 7060.00
                  token: "DHX")
              : SizedBox(),
              titleDetailRow(
                loading: !state.loadingMap.contains('stakedAmount'),
                name: FlutterI18n.translate(_ctx, 'staked_amount'),
                value: Tools.priceFormat((tkn == Token.MXC) ? state.stakedAmount : 7060.00),//TODO replace 7060.00
                token: (tkn == Token.MXC) ? "MXC" : "DHX"),
              titleDetailRow(
                loading: !state.loadingMap.contains('totalRevenue'),
                name: FlutterI18n.translate(_ctx, 'total_revenue'),
                value: Tools.priceFormat((tkn == Token.MXC) ? state.totalRevenue : 7060.00, range: 2),//TODO replace 7060.00
                token: (tkn == Token.MXC) ? "MXC" : "DHX")
            ],
          )
      )
  );

  Widget addNewTokenCard () => GestureDetector(
      onTap: () => _showAddTokenDialog(_ctx, dispatch),
      child: panelFrame(
        child: Padding(
          padding: kRoundRow105,
          child: Column(
            children: [
              Icon(Icons.add_circle, size: 50),
              Text(FlutterI18n.translate(_ctx, 'add_new_token'), style: kMiddleFontOfBlack)
            ],
          )
        ),
      ),
  );

  Widget miningDHXcard() => panelFrame(
      child: Padding(
          padding: kRoundRow105,
          child: Text("TODO mining DHX card")
      )
  );

  List<Widget> contractedView () {
    List<Widget> lst = state.displayTokens.map((t) => tokenCard(t)).toList();
    lst.add(addNewTokenCard());
    return lst;
  }

  Widget tokenPage(Token t) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: ListView(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Row(children:[
            (t == Token.MXC) ? Spacer() : SizedBox(),
            CircleButton(icon: Icon(Icons.add, color: (t == Token.DHX) ? Colors.grey : colorToken[t]),
                label: FlutterI18n.translate(_ctx, 'deposit'),
                onTap: () => (t == Token.DHX) ? 'disabled' : dispatch(HomeActionCreator.onOperate('deposit'))),
            Spacer(),
            CircleButton(icon: Icon(Icons.arrow_forward, color: (t == Token.DHX) ? Colors.grey : colorToken[t]),
                label: FlutterI18n.translate(_ctx, 'withdraw'),
                onTap: () => (t == Token.DHX) ? 'disabled' : dispatch(HomeActionCreator.onOperate('withdraw'))),
            Spacer(),
            CircleButton(icon:Image.asset(AppImages.iconMine, color: colorToken[t]),
                label: FlutterI18n.translate(_ctx, (t == Token.MXC) ? 'stake' : 'mine'), 
                onTap: () => (t == Token.DHX) ? 'TODO' : _showStakeDialog(_ctx, dispatch)),
            Spacer(),
            (t == Token.DHX) ? CircleButton(icon:Image.asset(AppImages.iconCouncil, color: colorToken[t]),
                label: FlutterI18n.translate(_ctx, 'council')) : SizedBox(),
          ]),
        ),
        tokenCard(t),
        (t == Token.DHX) ? miningDHXcard() : SizedBox(),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: CupertinoSlidingSegmentedControl(
              groupValue: state.activeTabToken[t],
              onValueChanged: (tabIndex) => dispatch(WalletActionCreator.onTab(tabIndex)),
              thumbColor: colorToken[t],
              children: <int, Widget> {
                0: Text(FlutterI18n.translate(_ctx, (t == Token.MXC) ? 'transaction_history' : "mining_income"), style: TextStyle(color: (state.activeTabToken[t] == 0) ? Colors.white: Colors.grey)),
                1: Text(FlutterI18n.translate(_ctx, (t == Token.MXC) ? 'stake_assets' : 'transaction_history'), style: TextStyle(color: (state.activeTabToken[t] == 1) ? Colors.white: Colors.grey))
              }
          ),
        ),
        //smallColumnSpacer(),
        Visibility(
          visible: t == Token.MXC && state.activeTabToken[t] == 0,
          child: secondaryButtons(
              buttonLabel1:
                  FlutterI18n.translate(_ctx, 'deposit').toUpperCase(),
              buttonLabel2:
                  FlutterI18n.translate(_ctx, 'withdraw').toUpperCase(),
              buttonLabel3:
                  FlutterI18n.translate(_ctx, 'set_date').toUpperCase(),
              selectedIndex: state.selectedIndexBtn1,
              onTap1: () => dispatch(WalletActionCreator.onFilter('DEPOSIT')),
              onTap2: () => dispatch(WalletActionCreator.onFilter('WITHDRAW')),
              onTap3: () => dispatch(WalletActionCreator.isSetDate())),
        ),
        Visibility(
          visible: t == Token.MXC && state.activeTabToken[t] == 1,
          child: secondaryButtons(
              buttonLabel1: FlutterI18n.translate(_ctx, 'stake').toUpperCase(),
              buttonLabel2:
                  FlutterI18n.translate(_ctx, 'unstake').toUpperCase(),
              buttonLabel3:
                  FlutterI18n.translate(_ctx, 'set_date').toUpperCase(),
              selectedIndex: state.selectedIndexBtn2,
              onTap1: () => dispatch(WalletActionCreator.onFilter('STAKE')),
              onTap2: () => dispatch(WalletActionCreator.onFilter('UNSTAKE')),
              onTap3: () => dispatch(WalletActionCreator.isSetDate())),
        ),
        Visibility(
          key: Key(''),
          visible: t == Token.MXC ? (state.activeTabToken[t] == 0 ? state.isSetDate1 : state.isSetDate2) : false,
          child: Padding(
            padding: EdgeInsets.only(top: 5),
            child: dateButtons(_ctx,
                firstTime: state.firstTime,
                secondTime: state.secondTime,
                thirdText: FlutterI18n.translate(_ctx, 'search'),
                firstTimeOnTap: (date) =>
                    dispatch(WalletActionCreator.firstTime(date)),
                secondTimeOnTap: (date) =>
                    dispatch(WalletActionCreator.secondTime(date)),
                onSearch: () =>
                    dispatch(WalletActionCreator.onFilter('SEARCH'))),
          ),
        ),
        panelFrame(
          rowTop: EdgeInsets.zero,
          child: state.loadingHistory
              ? LoadingList()
              : (adapter.itemCount != 0
                  ? ListView.builder(
                      itemBuilder: adapter.itemBuilder,
                      itemCount: adapter.itemCount,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                    )
                  : empty(_ctx)),
        ),
      ]
    ),
  );//tokenPage

  Widget expandedView () => PageView(
      controller: PageController(initialPage: state.selectedToken.index),
      onPageChanged: (val) => dispatch(WalletActionCreator.selectToken(Token.values[val])),
      children: state.displayTokens.map((t) => tokenPage(t)).toList());


  return Scaffold(
    appBar: homeBar(
      (state.expandedView)
          ? (state.selectedToken == Token.MXC) ? "MXC" : "Datahighway DHX"
          : FlutterI18n.translate(_ctx, 'wallet'),
      onPressed: () => dispatch(HomeActionCreator.onSettings()),
    ),
    body: state.expandedView
        ? pageBodySingleChild(usePadding: false, child: expandedView())
        : pageBody(children: contractedView(),
    ),
  );
}

void _showAddTokenDialog(BuildContext context, dispatch) {
  showInfoDialog(
      context,
      IosStyleBottomDialog2(
        context: context,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Text(FlutterI18n.translate(context, 'add_token_title'),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: s(16),
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              )
            ),
            Divider(color: Colors.grey),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: GestureDetector(
                  onTap: () {
                    dispatch(WalletActionCreator.addDHX());
                    Navigator.pop(context);
                  },
                  child:
                  Row(
                    children: [
                      Image.asset(AppImages.logoDHX, height: s(50)),
                      Text('Datahighway DHX',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: s(16),
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  )
              )
            ),
            Divider(color: Colors.grey),
          ],
        )
      )
  );
}

void _showStakeDialog(BuildContext context, dispatch) {
  showInfoDialog(
      context,
      IosStyleBottomDialog2(
          context: context,
          child: Column(
            children: [
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Text(FlutterI18n.translate(context, 'staking'),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: s(16),
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  )
              ),
              Divider(color: Colors.grey),
              GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    dispatch(WalletActionCreator.onStake());
                  },
                  child:
                  Row(
                    children: [
                      CircleButton(icon: Image.asset(AppImages.iconMine, color: colorToken[Token.MXC])),
                      SizedBox(width: 10),
                      Text(FlutterI18n.translate(context, 'new_stake'),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: s(16),
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  )
              ),
              Divider(color: Colors.grey),
              GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    dispatch(WalletActionCreator.onUnstake());
                  },
                  child:
                  Row(
                    children: [
                      CircleButton(icon: Icon(Icons.arrow_back, color: colorToken[Token.MXC])),
                      SizedBox(width: 10),
                      Text(FlutterI18n.translate(context, 'unstake'),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: s(16),
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  )
              ),
              Divider(color: Colors.grey),
            ],
          )
      )
  );
}
