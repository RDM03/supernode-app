import 'package:supernodeapp/common/daos/time_dao.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:supernodeapp/common/utils/tools.dart';

class Mining {
  static final weekStartDate = DateTime.now().add(Duration(days: -8));
  static final weekEndDate = DateTime.now().add(Duration(days: -1));

  final DateTime date;
  final double amount;

  Mining(this.date, this.amount);

  static List<Mining> _mapData(List source) {
    Map<DateTime, double> data = {};
    for (final item in source) {
      final sourceDate = DateTime.parse(item['date']);
      final realDate =
          DateTime.utc(sourceDate.year, sourceDate.month, sourceDate.day);
      data[realDate] = double.parse(item['amount']);
    }

    final weekStart = DateTime.utc(weekStartDate.year, weekStartDate.month, weekStartDate.day);
    final futureDayTemp = weekEndDate.add(Duration(days: 1));
    final futureDay = DateTime.utc(futureDayTemp.year, futureDayTemp.month, futureDayTemp.day);

    for (var i = weekStart;
        i.isBefore(futureDay);
        i = i.add(Duration(days: 1))) {
      if (data[i] == null) data[i] = 0.0;
    }

    final entries = data.entries.toList()
      ..sort((a, b) => a.key.compareTo(b.key));
    return entries.map((e) => Mining(e.key, e.value)).toList();
  }

  static List<charts.Series<Mining, DateTime>> getData(List data) {
    data ??= [];
    final newData = _mapData(data);

    return [
      new charts.Series<Mining, DateTime>(
        id: 'mining',
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
        domainFn: (Mining mining, _) => mining.date,
        measureFn: (Mining mining, _) => mining.amount,
        data: newData,
      )
    ];
  }
}

class GatewayFrame {
  static const secondaryMeasureAxisId = 'secondaryMeasureAxisId';

  final DateTime datetime;
  final double txData;

  GatewayFrame(this.txData, this.datetime);

  static List<charts.Series<GatewayFrame, String>> getData(List data) {
    data ??= [];
    final reveivedData = data
        .map((item) => new GatewayFrame(
            Tools.convertDouble(item['rxPacketsReceivedOK']),
            DateTime.parse(item['timestamp'])))
        .toList();

    final transmittedData = data
        .map((item) => new GatewayFrame(
            Tools.convertDouble(item['txPacketsEmitted']),
            DateTime.parse(item['timestamp'])))
        .toList();

    return [
      new charts.Series<GatewayFrame, String>(
        id: 'Transmitted',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (GatewayFrame frame, _) =>
            TimeDao.getDatetime(frame.datetime, type: 'day'),
        measureFn: (GatewayFrame frame, _) => frame.txData,
        data: transmittedData,
      ),
      new charts.Series<GatewayFrame, String>(
        id: 'Received',
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
        domainFn: (GatewayFrame frame, _) =>
            TimeDao.getDatetime(frame.datetime, type: 'day'),
        measureFn: (GatewayFrame frame, _) => frame.txData,
        data: reveivedData,
      )..setAttribute(charts.measureAxisIdKey, secondaryMeasureAxisId)
    ];
  }
}
