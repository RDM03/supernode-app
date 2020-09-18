import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/app_bars/home_bar.dart';
import 'package:supernodeapp/common/components/column_spacer.dart';
import 'package:supernodeapp/common/components/empty.dart';
import 'package:supernodeapp/common/components/loading_list.dart';
import 'package:supernodeapp/common/components/page/page_body.dart';
import 'package:supernodeapp/common/components/panel/panel_frame.dart';
import 'package:supernodeapp/common/components/stake/stake_item.dart';
import 'package:supernodeapp/common/components/wallet/date_buttons.dart';
import 'package:supernodeapp/common/components/wallet/list_item.dart';
import 'package:supernodeapp/common/components/wallet/primary_buttons.dart';
import 'package:supernodeapp/common/components/wallet/secondary_buttons.dart';
import 'package:supernodeapp/common/components/wallet/tab_buttons.dart';
import 'package:supernodeapp/common/components/wallet/title_detail_row.dart';
import 'package:supernodeapp/common/components/wallet/title_row.dart';
import 'package:supernodeapp/common/utils/tools.dart';
import 'package:supernodeapp/page/home_page/action.dart';
import 'package:supernodeapp/theme/font.dart';

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

  return Scaffold(
    appBar: homeBar(
      FlutterI18n.translate(_ctx, 'wallet'),
      onPressed: () => dispatch(HomeActionCreator.onSettings()),
    ),
    body: pageBody(
      children: [
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
                loading: state.loading,
                name: FlutterI18n.translate(_ctx, 'current_balance'),
                value: Tools.priceFormat(state.balance),
              ),
              primaryButtons(
                buttonLabel1: FlutterI18n.translate(_ctx, 'deposit'),
                onTap1: () => dispatch(HomeActionCreator.onOperate('deposit')),
                buttonLabel2: FlutterI18n.translate(_ctx, 'withdraw'),
                onTap2: () => dispatch(HomeActionCreator.onOperate('withdraw')),
              ),
            ]),
            Column(children: [
              smallColumnSpacer(),
              titleDetailRow(
                  loading: state.loading,
                  name: FlutterI18n.translate(_ctx, 'staked_amount'),
                  value: Tools.priceFormat(state.stakedAmount)),
              titleDetailRow(
                  loading: state.loading,
                  name: FlutterI18n.translate(_ctx, 'total_revenue'),
                  value: Tools.priceFormat(state.totalRevenue, range: 2)),
              primaryButtons(
                buttonLabel1: FlutterI18n.translate(_ctx, 'stake'),
                onTap1: () => dispatch(WalletActionCreator.onStake()),
                buttonLabel2: FlutterI18n.translate(_ctx, 'unstake'),
                onTap2: () => dispatch(WalletActionCreator.onUnstake()),
              ),
            ]),
          ],
        ),
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
          visible: state.tabIndex == 0 ? state.isSetDate1 : state.isSetDate2,
          child: Padding(
            padding: EdgeInsets.only(top: 5),
            child: dateButtons(viewService.context,
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
                      itemBuilder: (ctx, i) => buildWalletItemView(
                          state.getItemData(i), dispatch, viewService),
                      itemCount: state.itemCount,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                    )
                  : empty(_ctx)),
        ),
        SizedBox(
          height: 20,
        )
      ],
    ),
  );
}

Widget buildWalletItemView(
    GeneralItemState state, Dispatch dispatch, ViewService viewService) {
  var _ctx = viewService.context;
  if (state is WalletItemState) {
    String followText;
    TextStyle followStyle;
    if (state.amount > 0) {
      followText = '(' + FlutterI18n.translate(_ctx, 'deposit') + ')';
      followStyle = kSmallFontOfGreen;
    }
    if (state.amount < 0) {
      followText = '(' + FlutterI18n.translate(_ctx, 'withdraw') + ')';
      followStyle = kSmallFontOfRed;
    }
    return listItem(
      context: viewService.context,
      type: state.txType != null ? state.txType : state.type,
      amount: state.amount ?? state.stakeAmount,
      revenue: state.revenue,
      fee: state.fee,
      datetime: state.createdAt ??
          state.txSentTime ??
          state.startStakeTime ??
          state.start ??
          state.timestamp.toIso8601String(),
      secondDateTime: state.unstakeTime ?? state.end,
      fromAddress: state.fromAddress,
      toAddress: state.toAddress,
      txHashAddress: state.txHash,
      followText: followText,
      followStyle: followStyle,
      status: state.txStatus != null
          ? FlutterI18n.translate(_ctx, state.txStatus)
          : FlutterI18n.translate(_ctx, 'completed'),
      isExpand: state.isExpand,
      isLast: state.isLast,
    );
  }
  if (state is StakeItemState) {
    if (state.historyEntity.type != 'STAKING') return Container();
    return StakeItem.fromStake(
      state.historyEntity.stake,
      isLast: state.isLast,
      onTap: () => dispatch(
          WalletActionCreator.onStakeDetails(state.historyEntity.stake)),
    );
  }
  throw UnimplementedError('Unknown state type ${state.runtimeType}');
}
