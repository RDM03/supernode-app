import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/buttons/secondary_button.dart';
import 'package:supernodeapp/common/components/empty.dart';
import 'package:supernodeapp/common/components/loading_list.dart';
import 'package:supernodeapp/common/components/panel/panel_frame.dart';
import 'package:supernodeapp/common/components/row_spacer.dart';
import 'package:supernodeapp/common/components/wallet/date_buttons.dart';
import 'package:supernodeapp/common/components/wallet/list_item.dart';
import 'package:supernodeapp/common/repositories/supernode/dao/topup.model.dart';
import 'package:supernodeapp/common/repositories/supernode/dao/withdraw.dart';
import 'package:supernodeapp/common/utils/currencies.dart';
import 'package:supernodeapp/common/utils/time.dart';
import 'package:supernodeapp/page/home_page/bloc/supernode/mxc/cubit.dart';
import 'package:supernodeapp/page/home_page/bloc/supernode/mxc/state.dart';
import 'package:supernodeapp/theme/colors.dart';

class TransactionHistoryContent extends StatefulWidget {
  @override
  _TransactionHistoryContentState createState() =>
      _TransactionHistoryContentState();
}

enum TransactionHistoryFilter { deposit, withdraw }

class _TransactionHistoryContentState extends State<TransactionHistoryContent> {
  bool isSetDate = false;
  TransactionHistoryFilter filter;

  String firstTime = TimeUtil.getDatetime(new DateTime.now(), type: 'date');
  String secondTime = TimeUtil.getDatetime(new DateTime.now(), type: 'date');

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SupernodeMxcCubit, SupernodeMxcState>(
      buildWhen: (a, b) => a.topups != b.topups || a.withdraws != b.withdraws,
      builder: (ctx, state) {
        final withdraws = state.withdraws.value;
        final topups = state.topups.value;

        List<dynamic> list;
        if (withdraws != null && topups != null) {
          var tempWithdraws = withdraws;
          var tempTopups = topups;

          if (filter != null) {
            tempWithdraws = tempWithdraws
                .where((t) => filter == TransactionHistoryFilter.deposit
                    ? t.amountDouble > 0
                    : t.amountDouble < 0)
                .toList();
            tempTopups = tempTopups
                .where((t) => filter == TransactionHistoryFilter.deposit
                    ? t.amountDouble > 0
                    : t.amountDouble < 0)
                .toList();
          }

          list = [
            ...tempWithdraws,
            ...tempTopups,
          ];

          final _ = topups?.length == 1
              ? topups[0].timestamp.day
              : null; // static check that topup has timestamp field

          final __ = withdraws?.length == 1
              ? withdraws[0].timestamp.day
              : null; // static check that withdraw has timestamp field

          list?.sort((a, b) => b.timestamp.compareTo(a.timestamp));
        }

        return Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SecondaryButton(
                    key: ValueKey('depositKey'),
                    isSelected: filter == TransactionHistoryFilter.deposit,
                    buttonTitle:
                        FlutterI18n.translate(context, 'deposit').toUpperCase(),
                    color: filter == TransactionHistoryFilter.deposit
                        ? selectedTabColor
                        : Colors.white,
                    onTap: () {
                      if (filter == TransactionHistoryFilter.deposit)
                        setState(() => filter = null);
                      else
                        setState(
                            () => filter = TransactionHistoryFilter.deposit);
                    },
                  ),
                  smallRowSpacer(),
                  SecondaryButton(
                    key: ValueKey('withdrawKey'),
                    isSelected: filter == TransactionHistoryFilter.withdraw,
                    buttonTitle: FlutterI18n.translate(context, 'withdraw')
                        .toUpperCase(),
                    color: filter == TransactionHistoryFilter.withdraw
                        ? selectedTabColor
                        : Colors.white,
                    onTap: () {
                      if (filter == TransactionHistoryFilter.withdraw)
                        setState(() => filter = null);
                      else
                        setState(
                            () => filter = TransactionHistoryFilter.withdraw);
                    },
                  ),
                  smallRowSpacer(),
                  SecondaryButton(
                    isSelected: isSetDate,
                    buttonTitle: FlutterI18n.translate(context, 'set_date')
                        .toUpperCase(),
                    color: isSetDate ? selectedTabColor : Colors.white,
                    icon: Icons.date_range,
                    onTap: () {
                      setState(() => isSetDate = !isSetDate);
                    },
                  )
                ],
              ),
            ),
            if (isSetDate)
              Padding(
                padding: EdgeInsets.only(top: 5),
                child: dateButtons(
                  context,
                  firstTime: firstTime,
                  secondTime: secondTime,
                  thirdText: FlutterI18n.translate(context, 'search'),
                  firstTimeOnTap: (date) => setState(() => firstTime = date),
                  secondTimeOnTap: (date) => setState(() => secondTime = date),
                ),
              ),
            SizedBox(height: 12),
            PanelFrame(
              margin: EdgeInsets.zero,
              child: list == null
                  ? LoadingList()
                  : (list.length != 0
                      ? ListView.builder(
                          itemBuilder: (ctx, i) {
                            if (list[i] is TopupEntity) {
                              return TopupListItem(
                                key: ValueKey('walletItem_$i'),
                                entity: list[i],
                              );
                            }
                            if (list[i] is WithdrawHistoryEntity) {
                              return WithdrawListItem(
                                key: ValueKey('walletItem_$i'),
                                entity: list[i],
                                token: Token.mxc,
                              );
                            }
                            return Container();
                          },
                          itemCount: list.length,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                        )
                      : Empty()),
            ),
          ],
        );
      },
    );
  }
}
