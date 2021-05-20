import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supernodeapp/common/components/empty.dart';
import 'package:supernodeapp/common/components/loading_list.dart';
import 'package:supernodeapp/common/components/panel/panel_frame.dart';
import 'package:supernodeapp/common/components/wallet/list_item.dart';
import 'package:supernodeapp/common/utils/currencies.dart';
import 'package:supernodeapp/page/home_page/bloc/supernode/btc/cubit.dart';
import 'package:supernodeapp/page/home_page/bloc/supernode/btc/state.dart';

class TransactionsHistoryContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PanelFrame(
      margin: EdgeInsets.zero,
      child: BlocBuilder<SupernodeBtcCubit, SupernodeBtcState>(
        buildWhen: (a, b) => a.withdraws != b.withdraws,
        builder: (ctx, state) {
          if (state.withdraws.value == null) return LoadingList();
          final list = [...state.withdraws.value];
          list.sort((a, b) => b.timestamp.compareTo(a.timestamp));
          if (list.length == 0) return Empty();
          return ListView.builder(
            itemBuilder: (ctx, i) => WithdrawListItem(
              key: ValueKey('walletItem_$i'),
              entity: list[i],
              token: Token.btc,
            ),
            itemCount: list.length,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
          );
        },
      ),
    );
  }
}
