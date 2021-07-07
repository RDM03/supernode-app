import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/repositories/supernode/dao/wallet.model.dart';
import 'package:supernodeapp/common/utils/utils.dart';

import 'package:supernodeapp/page/home_page/bloc/supernode/gateway/state.dart';
import 'package:supernodeapp/page/view_all_page/bloc/state.dart';
import 'package:supernodeapp/page/view_all_page/view.dart';
import 'package:supernodeapp/route.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/font.dart';

import '../graph_card.dart';
import '../title.dart';

class MinerRevenueTab extends StatelessWidget {
  final GatewayItem item;
  final double sumRevenueLast7days;
  final List<DailyStatistic> revenueData;

  const MinerRevenueTab({
    Key key,
    @required this.item,
    @required this.sumRevenueLast7days,
    @required this.revenueData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 16),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: colorMxc05,
            borderRadius: BorderRadius.circular(10),
          ),
          width: double.infinity,
          height: 80,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${Tools.priceFormat(sumRevenueLast7days)} MXC',
                style: kVeryBigFontOfBlack,
              ),
              Text(
                FlutterI18n.translate(context, 'total_revenue'),
                style: kSmallFontOfGrey,
              )
            ],
          ),
        ),
        MinerDetailTitle(
          FlutterI18n.translate(context, 'revenue'),
          action: InkWell(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 6, vertical: 5),
              child: Text(
                FlutterI18n.translate(context, 'see_more'),
                style: kSmallFontOfDarkBlue,
              ),
            ),
            onTap: () => Navigator.of(context).push(
              route(
                (ctx) => ViewAllPage(
                  minerId: item.id,
                  type: MinerStatsType.revenue,
                ),
              ),
            ),
          ),
        ),
        GraphCard(
          subtitle: FlutterI18n.translate(context, 'weekly_amount'),
          title:
              '${Tools.priceFormat(revenueData?.fold<double>(0.0, (v, element) => double.parse(element.amount ?? '0.0') + v))} MXC',
          startDate: revenueData?.first?.date,
          endDate: revenueData?.last?.date,
          entities: revenueData
              ?.map(
                  (e) => GraphEntity(e.date, double.tryParse(e.amount ?? '0')))
              ?.toList(),
        ),
      ],
    );
  }
}
