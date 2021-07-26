import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/theme/font.dart';
import 'package:supernodeapp/theme/theme.dart';

class DDChartStats extends StatelessWidget {
  final String title;
  final String subTitle;
  final String upperLabel;

  const DDChartStats(
      {Key key,
      this.title = '',
      this.subTitle = '',
      this.upperLabel = ''})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        FlutterI18n.translate(context, title),
        style: FontTheme.of(context).middle.secondary(),
      ),
      subtitle: Flex(
        direction: Axis.horizontal,
        children: [
          Expanded(
            flex: 1,
            child: Text(
              subTitle,
              style: FontTheme.of(context)
                  .big
                  .mxc()
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              upperLabel,
              textAlign: TextAlign.right,
              style: FontTheme.of(context)
                  .big
                  .secondary()
                  .copyWith(fontWeight: FontWeight.bold),
              softWrap: true,
              overflow: TextOverflow.fade,
            ),
          )
        ],
      ),
    );
  }
}
