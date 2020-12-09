import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/app_bars/home_bar.dart';
import 'package:supernodeapp/common/components/column_spacer.dart';
import 'package:supernodeapp/common/components/empty.dart';
import 'package:supernodeapp/common/components/loading_list.dart';
import 'package:supernodeapp/common/components/page/page_body.dart';
import 'package:supernodeapp/common/components/panel/panel_frame.dart';
import 'package:supernodeapp/common/components/picker/ios_style_bottom_dailog.dart';
import 'package:supernodeapp/common/components/wallet/date_buttons.dart';
import 'package:supernodeapp/common/components/wallet/primary_buttons.dart';
import 'package:supernodeapp/common/components/wallet/secondary_buttons.dart';
import 'package:supernodeapp/common/components/wallet/tab_buttons.dart';
import 'package:supernodeapp/common/components/wallet/title_detail_row.dart';
import 'package:supernodeapp/common/components/wallet/title_row.dart';
import 'package:supernodeapp/common/utils/screen_util.dart';
import 'package:supernodeapp/common/utils/tools.dart';
import 'package:supernodeapp/configs/images.dart';
import 'package:supernodeapp/page/home_page/action.dart';
import 'package:supernodeapp/theme/font.dart';
import 'package:supernodeapp/theme/spacing.dart';

import 'action.dart';
import 'state.dart';

final List<String> tabList = [
  'account',
  'stake',
];

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
                  Icon(Icons.arrow_forward_ios)
                ]),
              ),
              titleDetailRow(
                loading: !state.loadingMap.contains('balance'),
                name: FlutterI18n.translate(_ctx, 'current_balance'),
                value: Tools.priceFormat((tkn == Token.MXC) ? state.balance : 7060.00),//TODO replace 7060.00
                token: (tkn == Token.MXC) ? "MXC" : "DHX"),
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
      onTap: () => _showInfoDialog(_ctx, dispatch),
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

  List<Widget> contractedView () {
    List<Widget> lst = state.displayTokes.map((t) => tokenCard(t)).toList();
    lst.add(addNewTokenCard());
    return lst;
  }

  List<Widget> expandedView () => [
        tabButtons(
            context: _ctx,
            tabController: state.tabController,
            list: tabList,
            height: state.tabHeight,
            onTap: (tabIndex) => dispatch(WalletActionCreator.onTab(tabIndex)),
            children: [
              Column(children: [
                middleColumnSpacer(),
                titleDetailRow(
                  loading: !state.loadingMap.contains('balance'),
                  name: FlutterI18n.translate(_ctx, 'current_balance'),
                  value: Tools.priceFormat(state.balance),
                ),
                primaryButtons(
                  key1: Key('deposit'),
                  buttonLabel1: FlutterI18n.translate(_ctx, 'deposit'),
                  onTap1: () =>
                      dispatch(HomeActionCreator.onOperate('deposit')),
                  key2: Key('withdraw'),
                  buttonLabel2: FlutterI18n.translate(_ctx, 'withdraw'),
                  onTap2: () =>
                      dispatch(HomeActionCreator.onOperate('withdraw')),
                ),
              ]),
              Column(children: [
                smallColumnSpacer(),
                titleDetailRow(
                    loading: !state.loadingMap.contains('stakedAmount'),
                    name: FlutterI18n.translate(_ctx, 'staked_amount'),
                    value: Tools.priceFormat(state.stakedAmount)),
                titleDetailRow(
                    loading: !state.loadingMap.contains('totalRevenue'),
                    name: FlutterI18n.translate(_ctx, 'total_revenue'),
                    value: Tools.priceFormat(state.totalRevenue, range: 2)),
                primaryButtons(
                  key1: Key('stake'),
                  buttonLabel1: FlutterI18n.translate(_ctx, 'stake'),
                  onTap1: () => dispatch(WalletActionCreator.onStake()),
                  key2: Key('unstake'),
                  buttonLabel2: FlutterI18n.translate(_ctx, 'unstake'),
                  onTap2: () => dispatch(WalletActionCreator.onUnstake()),
                ),
              ]),
            ]),
        smallColumnSpacer(),
        Visibility(
          visible: state.tabIndex == 0,
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
          visible: state.tabIndex == 1,
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
          visible: state.tabIndex == 0 ? state.isSetDate1 : state.isSetDate2,
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
        titleRow(FlutterI18n.translate(_ctx, 'transaction_history')),
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
        SizedBox(
          height: 20,
        )
  ];


  return Scaffold(
    appBar: homeBar(
      FlutterI18n.translate(_ctx, 'wallet'),
      onPressed: () => dispatch(HomeActionCreator.onSettings()),
    ),
    body: pageBody(
      children: state.expandedView ? expandedView() : contractedView(),
    ),
  );
}
void _showInfoDialog(BuildContext context, dispatch) {
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
