import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/repositories/supernode/dao/stake.model.dart';
import 'package:supernodeapp/common/utils/tools.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/font.dart';
import 'package:supernodeapp/theme/spacing.dart';
import 'package:supernodeapp/theme/theme.dart';

class StakeItem extends StatelessWidget {
  final VoidCallback onTap;
  final String amount;

  /// default MXC
  final String currency;

  /// for StakeDHXItemState/StakeDHXItemEntity
  final String stakedAmount;
  final String id;

  final DateTime startDate;
  final DateTime endDate;
  final DateTime lockTill;
  final int durationDays;
  final bool isLast;

  final Color iconColor;
  final int months;
  final bool showLockOpenIcon;

  StakeItem({
    this.onTap,
    this.amount,
    this.currency = 'MXC',
    this.stakedAmount = '',
    this.id,
    this.startDate,
    this.endDate,
    this.lockTill,
    this.durationDays,
    this.isLast,
    this.iconColor,
    this.months,
    this.showLockOpenIcon = true,
    Key key,
  }) : super(key: key);

  factory StakeItem.fromStake(Stake stake,
      {bool isLast = false, VoidCallback onTap, Key key}) {
    DateTime startDate;
    DateTime endDate;
    int durationDays;
    startDate = stake.startTime;
    final diffEndTime = stake.endTime ?? DateTime.now();
    final dateDiff = startDate.difference(diffEndTime).inDays.abs();
    durationDays = dateDiff;

    final amount = stake.amount.startsWith('-')
        ? stake.amount.substring(1, stake.amount.length)
        : stake.amount;

    final months = stake.months;
    Color iconColor;

    switch (months) {
      case 24:
        iconColor = stake24Color;
        break;
      case 12:
        iconColor = stake12Color;
        break;
      case 9:
        iconColor = stake9Color;
        break;
      case 6:
        iconColor = stake6Color;
        break;
      default:
        iconColor = stakeFlexColor;
        break;
    }
    if (months == 12) {
      iconColor = stake12Color;
    }

    // If the record is still in lock, so the icon is locked. If you unstake, the icon will be unlock
    var showLockOpenIcon = false;
    if ((stake.lockTill == null || stake.lockTill.isBefore(DateTime.now())) &&
        stake.endTime == null) {
      showLockOpenIcon = true;
    }

    if (months == null && stake.endTime == null) {
      showLockOpenIcon = false;
    }

    if (months == null && stake.endTime != null) {
      showLockOpenIcon = true;
    }

    return StakeItem(
      amount: amount,
      durationDays: durationDays,
      startDate: startDate,
      endDate: endDate,
      lockTill: stake.lockTill,
      months: stake.months,
      id: stake.id,
      isLast: isLast,
      iconColor: iconColor,
      onTap: onTap,
      showLockOpenIcon: showLockOpenIcon,
      key: key,
    );
  }

  @override
  Widget build(BuildContext context) {
    String dateStr = Tools.dateFormat(startDate);
    if (endDate != null) dateStr += '~' + Tools.dateFormat(endDate);
    dateStr = '${startDate.year}-${startDate.month}-${startDate.day}';
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Padding(
            padding: kRoundRow1505,
            child: Row(
              children: [
                Container(
                  height: 44,
                  width: 44,
                  alignment: Alignment.center,
                  child: Text(
                    months?.toString() ?? '~',
                    style: Theme.of(context).textTheme.bodyText1.copyWith(
                          color: ColorsTheme.of(context).textPrimaryAndIcons,
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  padding: EdgeInsets.only(top: 2),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: iconColor ?? stake24Color,
                  ),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text('$amount $currency',
                              style: FontTheme.of(context).big()),
                          SizedBox(
                            width: 5,
                          ),
                          Spacer(),
                          Container(
                            padding: kRoundRow5.copyWith(top: 2, bottom: 2),
                            child: Icon(
                              showLockOpenIcon
                                  ? Icons.lock_open
                                  : Icons.lock_outline,
                              size: 24,
                            ),
                          ),
                        ],
                      ),
                      (stakedAmount.isNotEmpty)
                          ? Text(
                              '$stakedAmount',
                              style: FontTheme.of(context).small.secondary(),
                            )
                          : SizedBox(),
                      Text(
                        'ID: ' + id,
                        style: FontTheme.of(context).small.secondary(),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            dateStr,
                            style: FontTheme.of(context).small.secondary(),
                          ),
                          Text(
                            FlutterI18n.translate(context, 'duration_days')
                                .replaceFirst('{0}', durationDays.toString()),
                            style: FontTheme.of(context).small.secondary(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (!isLast) Divider()
        ],
      ),
    );
  }
}
