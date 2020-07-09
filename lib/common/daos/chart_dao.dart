

import 'package:supernodeapp/common/daos/time_dao.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:supernodeapp/common/utils/tools.dart';

class Mining {
  final int month;
  final double amount;

  Mining(this.month,this.amount);

  static List blankDecoration(List data) {
    List blank = [];
    for(int i = 1;i <= 12;i++){
      blank.add({'amount': 0.0, 'month': i});
    }

    int total = data.length;
    for(int j = 0;j < total;j++){
      var item = data[j];
      blank[TimeDao.months[item['month']]-1]['amount'] = item['amount'];
    }

    if(total > 0){
      blank = blank.sublist(0,TimeDao.months[data[total - 1]['month']]);
    }

    return blank;
  }

  static List<charts.Series<Mining, int>> getData(List data) {
    List newData = blankDecoration(data);

    return [
      new charts.Series<Mining, int>(
        id: 'mining',
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
        domainFn: (Mining mining, _) => mining.month,
        measureFn: (Mining mining, _) => mining.amount,
        data: newData.map((item) => Mining(item['month'],item['amount'])).toList()
      )
    ];
  }
}

class GatewayFrame {
  static const secondaryMeasureAxisId = 'secondaryMeasureAxisId';
 
  final DateTime datetime;
  final double txData;

  GatewayFrame(this.txData,this.datetime);

  static List<charts.Series<GatewayFrame, String>> getData(List data) {
    final reveivedData = data.map((item) => new GatewayFrame(Tools.convertDouble(item['rxPacketsReceivedOK']),DateTime.parse(item['timestamp']))).toList();

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
      )..setAttribute(charts.measureAxisIdKey, secondaryMeasureAxisId)
    ];
  }
}