import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/wallet/list_item.dart';
import 'package:supernodeapp/theme/colors.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(GeneralItemState state, Dispatch dispatch, ViewService viewService) {
  var _ctx = viewService.context;
  if (state is WalletItemState) {
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
      onTap: () => dispatch(WalletItemActionCreator.isExpand(state))
    );
  }
  if (state is StakeItemState) {
    DateTime timeToShow;
    String amountText;
    Color amountColor;
    if (state.historyEntity.type == 'UNSTAKING') {
      timeToShow = state.historyEntity.stake.endTime;
      amountColor = Colors.transparent;
    } else if (state.historyEntity.type == 'STAKING') {
      timeToShow = state.historyEntity.stake.startTime;
      final endTime = state.historyEntity.stake.endTime ?? DateTime.now();
      final dateDiff = endTime.difference(endTime).inDays;
      amountText = FlutterI18n.translate(_ctx, 'duration_days').replaceFirst('{0}', dateDiff.toString());
      amountColor = Colors.transparent;
    } else if (state.historyEntity.type == 'STAKING_REWARD') {
      timeToShow = state.historyEntity.timestamp;
      amountColor = depositColor;
    }
    return listItem(
      context: viewService.context,
      type: state.itemType,
      amount: state.historyEntity == null 
        ? 0
        : double.tryParse(state.historyEntity.amount),
      revenue: null,
      //fee: state.fee,
      amountText: amountText,
      amountColor: amountColor,
      datetime: timeToShow?.toIso8601String(),
      // fromAddress: state.fromAddress,
      // toAddress: state.toAddress,
      // txHashAddress: state.txHash,
      //status: state.txStatus ?? FlutterI18n.translate(_ctx,'success'),
      isExpand: state.isExpand,
      isLast: state.isLast,
      onTap: () => dispatch(WalletItemActionCreator.isExpand(state))
    );
  }
  throw UnimplementedError('Unknown state type ${state.runtimeType}');
}
