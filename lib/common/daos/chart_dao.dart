

import 'package:supernodeapp/common/daos/time_dao.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:supernodeapp/common/utils/tools.dart';

class Mining {
  final String month;
  final double amount;

  Mining(this.month,this.amount);

  static List<charts.Series<Mining, double>> getData(List data) {
    return [
      new charts.Series<Mining, double>(
        id: 'mining',
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
        domainFn: (Mining mining, _) => TimeDao.months[mining.month].toDouble(),
        measureFn: (Mining mining, _) => mining.amount,
        data: data.map((item) => Mining(item['month'],item['amount'])).toList(),
      )
    ];
  }
}

class GatewayFrame {
  final DateTime datetime;
  final double txData;

  GatewayFrame(this.txData,this.datetime);

  static List<charts.Series<GatewayFrame, String>> getData(List data) {
    final reveivedData = data.map((item) => new GatewayFrame(Tools.convertDouble(item['txPacketsReceived']),DateTime.parse(item['timestamp']))).toList();

    final transmittedData = data.map((item) => new GatewayFrame(Tools.convertDouble(item['txPacketsEmitted']),DateTime.parse(item['timestamp']))).toList();


    return [
      new charts.Series<GatewayFrame, String>(
        id: 'Transmitted',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (GatewayFrame frame, _) => TimeDao.getDatetime(frame.datetime,type: 'day'),
        measureFn: (GatewayFrame frame, _) => frame.txData,
        data: transmittedData,
      ),
      new charts.Series<GatewayFrame, String>(
        id: 'Received',
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
        domainFn: (GatewayFrame frame, _) => TimeDao.getDatetime(frame.datetime,type: 'day'),
        measureFn: (GatewayFrame frame, _) => frame.txData,
        data: reveivedData,
      )
    ];
  }
}