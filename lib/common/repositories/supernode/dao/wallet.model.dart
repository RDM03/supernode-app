import 'dart:convert';

import 'package:flutter/foundation.dart';

class DailyStatistic {
  final String amount;
  final DateTime date;
  final double health;
  final int onlineSeconds;

  DailyStatistic({
    @required this.amount,
    @required this.date,
    @required this.health,
    @required this.onlineSeconds,
  });

  factory DailyStatistic.fromMap(Map<String, dynamic> map) {
    return DailyStatistic(
      amount: map['amount'],
      date: DateTime.tryParse(map['date']),
      health: map['health'].toDouble(),
      onlineSeconds: int.tryParse(map['onlineSeconds']),
    );
  }
}

class MiningIncomeGatewayResponse {
  final String total;
  final List<DailyStatistic> dailyStats;
  MiningIncomeGatewayResponse({
    @required this.total,
    @required this.dailyStats,
  });

  factory MiningIncomeGatewayResponse.fromMap(Map<String, dynamic> map) {
    return MiningIncomeGatewayResponse(
      total: map['total'],
      dailyStats: List<DailyStatistic>.from(
          map['dailyStats']?.map((x) => DailyStatistic.fromMap(x))),
    );
  }
}

class GatewayAmountRequest {
  final String amount;
  final String gatewayMac;

  GatewayAmountRequest(this.amount, this.gatewayMac);
}
