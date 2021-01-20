import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/app_bars/home_bar.dart';
import 'package:supernodeapp/common/components/app_bars/sign_up_appbar.dart';
import 'package:supernodeapp/common/components/buttons/circle_button.dart';
import 'package:supernodeapp/common/components/buttons/primary_button.dart';
import 'package:supernodeapp/common/components/empty.dart';
import 'package:supernodeapp/common/components/loading_flash.dart';
import 'package:supernodeapp/common/components/loading_list.dart';
import 'package:supernodeapp/common/components/page/page_body.dart';
import 'package:supernodeapp/common/components/panel/panel_frame.dart';
import 'package:supernodeapp/common/components/picker/ios_style_bottom_dailog.dart';
import 'package:supernodeapp/common/components/wallet/date_buttons.dart';
import 'package:supernodeapp/common/components/wallet/mining_tutorial.dart';
import 'package:supernodeapp/common/components/wallet/secondary_buttons.dart';
import 'package:supernodeapp/common/components/wallet/title_detail_row.dart';
import 'package:supernodeapp/common/daos/local_storage_dao.dart';
import 'package:supernodeapp/common/utils/currencies.dart';
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
        child: Padding (padding: EdgeInsets.symmetric(vertical: 10),
          child: Column(
            children: [
              Container(
                padding: kRoundRow15_5,
                child: Row(children: [
                  Image.asset(tkn.imagePath),
                  SizedBox(width: s(3)),
                  Text(tkn.name, style: kBigBoldFontOfBlack),
                  Spacer(),
                  state.expandedView
                      ? (tkn == Token.supernodeDhx)
                        ? PrimaryButton(
                      bgColor: Token.supernodeDhx.color,
                      buttonTitle: FlutterI18n.translate(_ctx, 'simulate_mining'),
                      onTap: () => Navigator.pushNamed(_ctx, 'mining_simulator_page', arguments: {'isDemo': state.isDemo, 'balance': state.balance}))
                        : SizedBox()
                      : Icon(Icons.arrow_forward_ios)
                ]),
              ),
              titleDetailRow(
                loading: !state.loadingMap.contains((tkn == Token.mxc) ? 'balance' : LocalStorageDao.balanceDHXKey),
                name: FlutterI18n.translate(_ctx, 'current_balance'),
                value: Tools.priceFormat((tkn == Token.mxc) ? state.balance : state.balanceDHX),
                token: tkn.name),

              (tkn == Token.supernodeDhx)
              ? titleDetailRow(
                  loading: !state.loadingMap.contains(LocalStorageDao.lockedAmountKey),
                  name: FlutterI18n.translate(_ctx, 'locked_amount'),
                  value: Tools.priceFormat(state.lockedAmount),
                  token: Token.mxc.name)
              : SizedBox(),

              titleDetailRow(
                loading: (tkn == Token.mxc) && !state.loadingMap.contains('stakedAmount'),
                name: FlutterI18n.translate(_ctx, 'staked_amount'),
                value: (tkn == Token.mxc) ? Tools.priceFormat(state.stakedAmount) : FlutterI18n.translate(_ctx, 'not_available'),
                token: (tkn == Token.mxc) ? Token.mxc.name : ""),

              titleDetailRow(
                loading: !state.loadingMap.contains((tkn == Token.mxc) ? 'totalRevenue' : LocalStorageDao.lockedAmountKey),
                name: FlutterI18n.translate(_ctx, 'total_revenue'),
                value: Tools.priceFormat((tkn == Token.mxc) ? state.totalRevenue : state.totalRevenueDHX, range: 2),
                token: tkn.name)
            ]),
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
      child: Padding (padding: EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children: [
            SizedBox(height: s(5)),
            Container(
            padding: kRoundRow15_5,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(FlutterI18n.translate(_ctx, "mining"), style: kBigBoldFontOfBlack),
                  Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(FlutterI18n.translate(_ctx, "daily_mining_capacity"), style: kSmallFontOfBlack),
                      SizedBox(height: s(5)),
                      Text('5000 DHX', style: MiddleFontOfColor(color: Token.supernodeDhx.color)),
                    ],
                  ),
                ]
              ),
            ),
          SizedBox(height: s(20)),
          Row(children:[
            Spacer(),
            Column(children: [
              Text('${state.gatewaysTotal}', style: kSuperBigBoldFont),
              SizedBox(height: s(5)),
              Container(
                decoration: BoxDecoration(
                  color: Token.supernodeDhx.color,
                  borderRadius: BorderRadius.all(Radius.circular(5))),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                  child: Text(FlutterI18n.translate(_ctx, 'm2pro_miner'), style: kSecondaryButtonOfWhite),
                )
              )
            ]),
            Spacer(),
            Column(children: [
              !state.loadingMap.contains(LocalStorageDao.lockedAmountKey)
              ? loadingFlash(child: Text(Tools.numberRounded(state.mPower), style: kPrimaryBigFontOfBlack))
              : Text(Tools.numberRounded(state.mPower), style: kSuperBigBoldFont),
              SizedBox(height: s(5)),
              Container(
                decoration: BoxDecoration(
                  color: Token.supernodeDhx.color,
                  borderRadius: BorderRadius.all(Radius.circular(5))),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                  child: Stack(alignment: AlignmentDirectional.center, children: [
                    Text(FlutterI18n.translate(_ctx, 'm2pro_miner'), style:TextStyle(color: Token.supernodeDhx.color, fontFamily: "Roboto", fontSize: 14)),// invisible - sets width for Container
                    Text(FlutterI18n.translate(_ctx, 'mpower'), style: kSecondaryButtonOfWhite)
                  ])
                )
              )
            ]),
            Spacer()
          ]),
          SizedBox(height: s(10)),
          titleDetailRow(
            name: FlutterI18n.translate(_ctx, 'estimated_dxh_daily_return'),
            value: FlutterI18n.translate(_ctx, 'coming'),
            token: "",
            disabled: true),
          titleDetailRow(
            loading: !state.loadingMap.contains(LocalStorageDao.miningPowerKey),
            name: FlutterI18n.translate(_ctx, 'supernode_mining_power'),
            value: Tools.numberRounded(state.miningPower),
            token: "mPower"),
        ]),
      )
  );

  List<Widget> contractedView () {
    List<Widget> lst = state.displayTokens.map((t) => tokenCard(t)).toList();
    lst.add(addNewTokenCard());
    return lst;
  }

  Widget tokenPage(Token t) => Padding(
    padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
    child: ListView(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Row(children:[
            (t == Token.mxc) ? Spacer() : SizedBox(),
            CircleButton(icon: Icon(Icons.add, color: (t == Token.supernodeDhx) ? Colors.grey : t.color),
                label: FlutterI18n.translate(_ctx, 'deposit'),
                onTap: () => (t == Token.supernodeDhx) ? 'disabled' : dispatch(HomeActionCreator.onOperate('deposit'))),
            Spacer(),
            CircleButton(icon: Icon(Icons.arrow_forward, color: (t == Token.supernodeDhx) ? Colors.grey : t.color),
                label: FlutterI18n.translate(_ctx, 'withdraw'),
                onTap: () => (t == Token.supernodeDhx) ? 'disabled' : dispatch(HomeActionCreator.onOperate('withdraw'))),
            Spacer(),
            CircleButton(icon:Image.asset(AppImages.iconMine, color: t.color),
                label: FlutterI18n.translate(_ctx, (t == Token.mxc) ? 'stake' : 'mine'), 
                onTap: () => (t == Token.supernodeDhx) ? _showMineDXHDialog(_ctx, state.isDemo) : _showStakeDialog(_ctx, dispatch)),
            Spacer(),
            (t == Token.supernodeDhx)
              ? CircleButton(
                icon:Image.asset(AppImages.iconCouncil, color: (state.stakeDHXList == []) ? Colors.grey : t.color),
                label: FlutterI18n.translate(_ctx, 'council'),
                onTap: () {
                  Set<String> argJoinedCouncils = state.stakeDHXList.where((e) => !e.historyEntity.closed).map((e) => e.historyEntity.councilId).toSet();
                  (state.stakeDHXList == [])
                      ? "do nothing"
                      : Navigator.pushNamed(_ctx, 'list_councils_page', arguments: {'isDemo': state.isDemo, 'joinedCouncilsId': argJoinedCouncils});
                    }
            )
              : SizedBox(),
          ]),
        ),
        tokenCard(t),
        (t == Token.supernodeDhx) ? miningDHXcard() : SizedBox(),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: CupertinoSlidingSegmentedControl(
              groupValue: state.activeTabToken[t],
              onValueChanged: (tabIndex) => dispatch(WalletActionCreator.onTab(tabIndex)),
              thumbColor: t.color,
              children: <int, Widget> {
                0: Text(FlutterI18n.translate(_ctx, (t == Token.mxc) ? 'transaction_history' : "mining_income"), style: TextStyle(color: (state.activeTabToken[t] == 0) ? Colors.white: Colors.grey)),
                1: Text(FlutterI18n.translate(_ctx, (t == Token.mxc) ? 'stake_assets' : 'transaction_history'), style: TextStyle(color: (state.activeTabToken[t] == 1) ? Colors.white: Colors.grey))
              }
          ),
        ),
        //smallColumnSpacer(),
        Visibility(
          visible: t == Token.mxc && state.activeTabToken[t] == 0,
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
          visible: t == Token.mxc && state.activeTabToken[t] == 1,
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
          visible: t == Token.mxc ? (state.activeTabToken[t] == 0 ? state.isSetDate1 : state.isSetDate2) : false,
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

  Widget pageviewIndicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 3),
      height: 5,
      width: isActive ? 20 : 19,
      decoration: BoxDecoration(
          color: isActive ? state.selectedToken.color : Colors.grey,
          borderRadius: BorderRadius.all(Radius.circular(2))),
    );
  }

  Widget expandedView () => Stack (
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        PageView(
            controller: PageController(initialPage: state.selectedToken.index),
            onPageChanged: (val) => dispatch(WalletActionCreator.selectToken(Token.values[val])),
            children: state.displayTokens.map((t) => tokenPage(t)).toList()),
        (state.displayTokens.length > 1)
        // PageView indicator
        ? Container(
          width: double.infinity,
          height: 20,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: shodowColor,
                offset: Offset(0, 2),
                blurRadius: 7,
              ),
            ],
          ),
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: <Widget> [
              Container(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    for (int i = 0; i < state.displayTokens.length; i++)
                      if (state.displayTokens[i] == state.selectedToken) ...[pageviewIndicator(true)] else
                        pageviewIndicator(false),
                  ],
                ),
              ),
            ],
          ),
        )
        : SizedBox()
      ],
  );


  return Scaffold(
    appBar: homeBar(
      (state.expandedView)
          ? state.selectedToken.fullName
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
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
                dispatch(HomeActionCreator.onAddDHX(true));},
              child: Row(
                children: [
                  Image.asset(AppImages.logoDHX, height: s(50)),
                  SizedBox(width: s(10)),
                  Text(Token.supernodeDhx.fullName,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: s(16),
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  )
                ],
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
                      CircleButton(icon: Image.asset(AppImages.iconMine, color: Token.mxc.color)),
                      SizedBox(width: s(10)),
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
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    Navigator.pop(context);
                    dispatch(WalletActionCreator.onUnstake());
                  },
                  child:
                  Row(
                    children: [
                      CircleButton(icon: Icon(Icons.arrow_back, color: Token.mxc.color)),
                      SizedBox(width: s(10)),
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

void _showMineDXHDialog(BuildContext context, bool isDemo) {
  showInfoDialog(
      context,
      IosStyleBottomDialog2(
          context: context,
          child: Column(
            children: [
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Text(FlutterI18n.translate(context, 'mining'),
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

                    Navigator.pushNamed(context, 'lock_page', arguments: {
                      'isDemo': isDemo
                    });

                    Navigator.push(context, MaterialPageRoute<void> (
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
                  child:
                  Row(
                    children: [
                      CircleButton(icon: Image.asset(AppImages.iconMine, color: Token.supernodeDhx.color)),
                      SizedBox(width: s(10)),
                      Text(FlutterI18n.translate(context, 'new_mining'),
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
                  },
                  child:
                  Row(
                    children: [
                      CircleButton(icon: Icon(Icons.arrow_back, color: Colors.grey)),
                      SizedBox(width: s(10)),
                      Text(FlutterI18n.translate(context, 'unlock'),
                        style: TextStyle(
                          color: Colors.grey,
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