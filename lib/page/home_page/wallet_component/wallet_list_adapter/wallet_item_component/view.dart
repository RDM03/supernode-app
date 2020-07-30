import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/wallet/list_item.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(WalletItemState state, Dispatch dispatch, ViewService viewService) {
  var _ctx = viewService.context;

  return listItem(
    context: viewService.context,
    type: state.txType != null ? state.txType : state.type,
    amount: state.amount ?? state.stakeAmount,
    revenue: state.revenue,
    fee: state.fee,
    datetime: state.createdAt ?? state.txSentTime ?? state.startStakeTime ?? state.start ?? state.timestamp.toIso8601String(),
    secondDateTime: state.unstakeTime ?? state.end,
    fromAddress: state.fromAddress,
    toAddress: state.toAddress,
    txHashAddress: state.txHash,
    status: state.txStatus ?? FlutterI18n.translate(_ctx,'success'),
    isExpand: state.isExpand,
    isLast: state.isLast,
    onTap: () => dispatch(WalletItemActionCreator.isExpand(state.id))
  );
}
