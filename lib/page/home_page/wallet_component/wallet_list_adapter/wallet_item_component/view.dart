import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/wallet/list_item.dart';
import 'package:supernodeapp/common/daos/time_dao.dart';
import 'package:supernodeapp/common/utils/tools.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/font.dart';
import 'package:supernodeapp/theme/spacing.dart';

import 'action.dart';
import 'state.dart';

class StakeItem extends StatelessWidget {
  final VoidCallback onTap;
  final String titleSuffix;
  final String amount;
  final String id;
  final DateTime startDate;
  final DateTime endDate;
  final int durationDays;
  final Color amountColor;
  final bool isLast;

  StakeItem({
    this.onTap, this.titleSuffix, this.amount, this.id, this.startDate, this.endDate, this.durationDays, this.amountColor, this.isLast
  });


  @override
  Widget build(BuildContext context) {
    final detailsElements = [
      if(startDate != null) Text(
        TimeDao.getDatetime(startDate),
        style: kSmallFontOfGrey
      ),
      if(endDate != null) Text(
        TimeDao.getDatetime(endDate),
        style: kSmallFontOfGrey
      ),
      if(durationDays != null) Text(
        FlutterI18n.translate(context, 'duration_days').replaceFirst('{0}', durationDays.toString()),
        style: kSmallFontOfGrey
      ),
      if(id != null) Text(
        'ID: $id',
        style: kSmallFontOfGrey
      ),
    ];
    return Column(
      children:
      [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 10,
          ),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text('MXC/ETH', style: kBigFontOfBlack),
                  SizedBox(width: 5,),
                  if (titleSuffix != null) Text(titleSuffix, style: kSmallFontOfGrey),
                  Spacer(),

                  Container(
                    padding: kRoundRow5.copyWith(
                      top: 2,
                      bottom: 2
                    ),
                    decoration: BoxDecoration(
                      color: amountColor,
                      borderRadius: BorderRadius.all(Radius.circular(7)),
                    ),
                    child: Text(
                      '${Tools.convertDouble(amount)} MXC',
                      style: kBigFontOfBlack,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              if (detailsElements.length % 2 == 1) ...[
                Row(
                  children: <Widget>[
                    detailsElements[0],
                    Spacer(),
                  ],
                ),
                SizedBox(height: 3),
              ],
              for (var i = detailsElements.length % 2; i < detailsElements.length; i += 2) ...[
                Row(
                  children: <Widget>[
                    detailsElements[i],
                    Spacer(),
                    detailsElements[i+1],
                  ],
                ),
                SizedBox(height: 3),
              ],
            ],
          )
        ),
        if (!isLast) Divider()
      ]
    );
  }
}

int i = 0;
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
    DateTime startDate;
    DateTime endDate;
    int durationDays;
    Color amountColor;
    String followText;
    if (state.historyEntity.type == 'UNSTAKING') {
      startDate = state.historyEntity.stake.startTime;
      endDate = state.historyEntity.stake.endTime;
      final diffEndTime = state.historyEntity.stake.endTime ?? DateTime.now();
      final dateDiff = diffEndTime.difference(diffEndTime).inDays;
      durationDays = dateDiff;
      amountColor = depositColor;
      followText = FlutterI18n.translate(_ctx, 'unstake');
    } else if (state.historyEntity.type == 'STAKING') {
      startDate = state.historyEntity.stake.startTime;
      final diffEndTime = state.historyEntity.stake.endTime ?? DateTime.now();
      final dateDiff = diffEndTime.difference(diffEndTime).inDays;
      durationDays = dateDiff;
      amountColor = Colors.transparent;
      followText = FlutterI18n.translate(_ctx, 'stake');
    } else if (state.historyEntity.type == 'STAKING_REWARD') {
      startDate = state.historyEntity.timestamp;
      amountColor = depositColor;
      followText = FlutterI18n.translate(_ctx, 'staking_revenue');
    }

    return StakeItem(
      amount: state.historyEntity.amount,
      durationDays: durationDays,
      amountColor: amountColor,
      startDate: startDate,
      endDate: endDate,
      id: state.historyEntity.stake.id,
      isLast: state.isLast,
      titleSuffix: '($followText)',
      onTap: () => dispatch(WalletItemActionCreator.isExpand(state))
    );
  }
  throw UnimplementedError('Unknown state type ${state.runtimeType}');
}
