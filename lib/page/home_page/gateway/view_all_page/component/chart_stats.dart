import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/theme/font.dart';

class DDChartStats extends StatelessWidget {
  final String title;
  final String subTitle;
  final String startTime;
  final String endTime;

  const DDChartStats(
      {Key key,
      this.title = '',
      this.subTitle = '',
      this.startTime,
      this.endTime})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        FlutterI18n.translate(context, title),
        style: kMiddleFontOfGrey,
      ),
      subtitle: Flex(
        direction: Axis.horizontal,
        children: [
          Expanded(
            flex: 1,
            child: Text(
              subTitle,
              style: kBigFontOfDarkBlue.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              '$startTime - $endTime',
              textAlign: TextAlign.right,
              style: kBigFontOfGrey.copyWith(fontWeight: FontWeight.bold),
              softWrap: true, 
              overflow: TextOverflow.fade,
            ),
          )
        ],
      ),
    );
  }
}
