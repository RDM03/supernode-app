import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supernodeapp/common/components/empty.dart';
import 'package:supernodeapp/common/components/loading_list.dart';
import 'package:supernodeapp/common/components/panel/panel_frame.dart';
import 'package:supernodeapp/common/components/stake/stake_item.dart';
import 'package:supernodeapp/common/utils/currencies.dart';
import 'package:supernodeapp/common/utils/utils.dart';
import 'package:supernodeapp/page/home_page/bloc/supernode/dhx/cubit.dart';
import 'package:supernodeapp/page/home_page/bloc/supernode/dhx/state.dart';

class MiningIncomeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PanelFrame(
      rowTop: EdgeInsets.zero,
      child: BlocBuilder<SupernodeDhxCubit, SupernodeDhxState>(
        buildWhen: (a, b) => a.stakes != b.stakes,
        builder: (ctx, state) {
          if (state.stakes.loading) {
            return LoadingList();
          }
          if (state.stakes.value.isEmpty) {
            return Empty();
          }
          return ListView.builder(
            itemCount: state.stakes.value.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (ctx, i) {
              final stake = state.stakes.value[i];
              final month = (stake.lockTill == null)
                  ? null
                  : (stake.lockTill.difference(stake.created).inDays / 30)
                      .floor();

              // If the record is still in lock, so the icon is locked. If you unstake, the icon will be unlock
              final showLockOpenIcon = (stake.lockTill == null ||
                  stake.lockTill.isBefore(DateTime.now()));

              final dateDiff = (showLockOpenIcon)
                  ? 0
                  : stake.lockTill.difference(DateTime.now()).inDays.abs();

              return StakeItem(
                key: Key('dhx_stake_$i'),
                amount: Tools.priceFormat(
                  Tools.convertDouble(stake.dhxMined),
                  range: 2,
                ),
                currency: 'DHX',
                isLast: i + 1 == state.stakes.value.length,
                stakedAmount: '${stake.amount} ${stake.currency}',
                id: stake.id,
                startDate: stake.created,
                durationDays: dateDiff,
                iconColor: Token.supernodeDhx.color,
                months: month,
                showLockOpenIcon: showLockOpenIcon,
              );
            },
          );
        },
      ),
    );
  }
}
