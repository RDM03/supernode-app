import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:supernodeapp/common/utils/tools.dart';

class Mining {
  static final weekStartDate = DateTime.now().add(Duration(days: -8));
  static final weekEndDate = DateTime.now().add(Duration(days: -1));

  final DateTime date;
  final double amount;

  Mining(this.date, this.amount);

  static List<Mining> mapData(List source) {
    Map<DateTime, double> data = {};
    for (final item in source) {
      final sourceDate = DateTime.parse(item['date']);
      final realDate =
          DateTime.utc(sourceDate.year, sourceDate.month, sourceDate.day);
      data[realDate] = double.parse(item['amount']);
    }

    final weekStart = DateTime.utc(
        weekStartDate.year, weekStartDate.month, weekStartDate.day);
    final futureDayTemp = weekEndDate.add(Duration(days: 1));
    final futureDay = DateTime.utc(
        futureDayTemp.year, futureDayTemp.month, futureDayTemp.day);

    for (var i = weekStart;
        i.isBefore(futureDay);
        i = i.add(Duration(days: 1))) {
      if (data[i] == null) data[i] = 0.0;
    }

    final entries = data.entries.toList()
      ..sort((a, b) => a.key.compareTo(b.key));
    return entries.map((e) => Mining(e.key, e.value)).toList();
  }

  static LineChartBarData getData(List data) {
    data ??= [];
    final newData = mapData(data);
    return LineChartBarData(
      spots: newData.map(
          (e) => FlSpot(e.date.millisecondsSinceEpoch.toDouble(), e.amount)),
      colors: [Colors.green],
    );
  }
}

class GatewayFrameData {
  final double received;
  final double transmitted;

  GatewayFrameData({
    @required this.received,
    @required this.transmitted,
  });
}

class GatewayFrame {
  static const secondaryMeasureAxisId = 'secondaryMeasureAxisId';

  final DateTime datetime;
  final double txData;

  GatewayFrame(this.txData, this.datetime);

  static Map<DateTime, GatewayFrameData> mapData(List source) {
    final received = source
        .map((item) => new GatewayFrame(
            Tools.convertDouble(item['rxPacketsReceivedOK']),
            DateTime.parse(item['timestamp'])))
        .toList();
    final transmitted = source
        .map((item) => new GatewayFrame(
            Tools.convertDouble(item['txPacketsEmitted']),
            DateTime.parse(item['timestamp'])))
        .toList();
    final res = <DateTime, GatewayFrameData>{};
    for (final r in received) {
      final dateTime =
          DateTime(r.datetime.year, r.datetime.month, r.datetime.day);
      res[dateTime] = GatewayFrameData(
        received: r.txData,
        transmitted: res[dateTime]?.transmitted,
      );
    }
    for (final t in transmitted) {
      final dateTime =
          DateTime(t.datetime.year, t.datetime.month, t.datetime.day);
      res[dateTime] = GatewayFrameData(
        transmitted: t.txData,
        received: res[dateTime]?.received,
      );
    }
    return res;
  }
}
