import 'package:flutter/material.dart';
import 'package:supernodeapp/common/utils/tools.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/font.dart';
import 'package:supernodeapp/theme/spacing.dart';

class Stake {
  final String id;
  final DateTime startTime;
  final DateTime endTime;
  final String amount;
  final bool active;
  final DateTime lockTill;
  final String boost;
  final double revenue;

  int get months {
    if (lockTill == null) return null;
    return (lockTill.difference(startTime).inDays / 30).floor();
  }

  Stake({
    this.id,
    this.startTime,
    this.endTime,
    this.amount,
    this.active,
    this.lockTill,
    this.boost,
    this.revenue,
  });

  factory Stake.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Stake(
      id: map['id'],
      amount: map['amount'],
      active: map['active'] ?? false,
      lockTill:
          map['lockTill'] != null ? DateTime.tryParse(map['lockTill']) : null,
      boost: map['boost'],
      startTime:
          map['startTime'] != null ? DateTime.tryParse(map['startTime']) : null,
      endTime:
          map['endTime'] != null ? DateTime.tryParse(map['endTime']) : null,
      revenue: map['revenue'] != null ? double.tryParse(map['revenue']) : null,
    );
  }

  Stake copyWith({
    String id,
    DateTime startTime,
    DateTime endTime,
    String amount,
    bool active,
  }) {
    return Stake(
      id: id ?? this.id,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      amount: amount ?? this.amount,
      active: active ?? this.active,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'startTime': startTime?.toIso8601String(),
      'endTime': endTime?.toIso8601String(),
      'amount': amount,
      'active': active,
    };
  }

  @override
  String toString() {
    return 'Stake(id: $id, startTime: $startTime, endTime: $endTime, amount: $amount, active: $active)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Stake &&
        o.id == id &&
        o.startTime == startTime &&
        o.endTime == endTime &&
        o.amount == amount &&
        o.active == active;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        startTime.hashCode ^
        endTime.hashCode ^
        amount.hashCode ^
        active.hashCode;
  }
}

class StakeItem extends StatelessWidget {
  final VoidCallback onTap;
  final String amount;
  final String id;

  final DateTime startDate;
  final DateTime endDate;
  final DateTime lockTill;
  final int durationDays;
  final bool isLast;

  final Color iconColor;
  final int months;

  StakeItem({
    this.onTap,
    this.amount,
    this.id,
    this.startDate,
    this.endDate,
    this.lockTill,
    this.durationDays,
    this.isLast,
    this.iconColor,
    this.months,
  });

  factory StakeItem.fromStake(Stake stake,
      {bool isLast = false, VoidCallback onTap}) {
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
            padding: EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 10,
            ),
            child: Row(
              children: [
                Container(
                  height: 44,
                  width: 44,
                  alignment: Alignment.center,
                  child: Text(
                    months?.toString() ?? '~',
                    style: Theme.of(context).textTheme.bodyText1.copyWith(
                          color: Colors.white,
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
                          Text('$amount MXC', style: kBigFontOfBlack),
                          SizedBox(
                            width: 5,
                          ),
                          Spacer(),
                          Container(
                            padding: kRoundRow5.copyWith(top: 2, bottom: 2),
                            child: Icon(
                              lockTill == null ||
                                      lockTill.isBefore(DateTime.now())
                                  ? Icons.lock_open
                                  : Icons.lock_outline,
                              size: 24,
                            ),
                          ),
                        ],
                      ),
                      Text(id, style: kSmallFontOfGrey),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(dateStr, style: kSmallFontOfGrey),
                          Text('$durationDays Days', style: kSmallFontOfGrey),
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
