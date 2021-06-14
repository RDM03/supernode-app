import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/widgets/circular_graph.dart';
import 'package:supernodeapp/common/repositories/supernode/dao/wallet.model.dart';
import 'package:supernodeapp/common/utils/utils.dart';
import 'package:supernodeapp/configs/images.dart';
import 'package:supernodeapp/page/add_fuel_page/add_fuel_page.dart';
import 'package:supernodeapp/page/home_page/bloc/supernode/gateway/state.dart';
import 'package:supernodeapp/page/send_to_wallet_page/send_to_wallet_page.dart';
import 'package:supernodeapp/page/view_all_page/bloc/state.dart';
import 'package:supernodeapp/page/view_all_page/view.dart';
import 'package:supernodeapp/route.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/font.dart';

import '../graph_card.dart';
import '../title.dart';

class MinerHealthTab extends StatelessWidget {
  final GatewayItem item;
  final List<DailyStatistic> healthStatistics;
  final double avgSecondsOnlinePerDay;
  final VoidCallback onRefresh;

  const MinerHealthTab({
    Key key,
    this.item,
    this.healthStatistics,
    this.avgSecondsOnlinePerDay,
    this.onRefresh,
  }) : super(key: key);

  Widget infoCard({
    @required Widget image,
    @required int value,
    @required String title,
    @required String description,
    @required String comment,
    bool enabled = false,
  }) =>
      Container(
        margin: EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white.withOpacity(enabled ? 1 : 0.5),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 0,
              blurRadius: 1,
              offset: Offset(0, 0),
            )
          ],
        ),
        child: Row(
          children: [
            Column(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  foregroundDecoration: enabled
                      ? null
                      : BoxDecoration(
                          color: Colors.grey.shade200,
                          shape: BoxShape.circle,
                          backgroundBlendMode: BlendMode.saturation,
                        ),
                  child: image,
                ),
                Text(
                  '$value%',
                  textAlign: TextAlign.center,
                  style: enabled ? kBigFontOfDarkBlue : kBigFontOfGrey,
                ),
              ],
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    title,
                    style: enabled ? kBigFontOfDarkBlue : kBigFontOfGrey,
                  ),
                  SizedBox(height: 4),
                  Text(
                    description,
                    style: enabled ? kMiddleFontOfBlack : kMiddleFontOfGrey,
                  ),
                  SizedBox(height: 4),
                  Text(comment, style: kMiddleFontOfGrey),
                ],
              ),
            )
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(width: 16),
            GestureDetector(
              onTap: item.health == 1
                  ? null
                  : () => Navigator.of(context)
                      .push(route((ctx) => AddFuelPage(gatewayItem: item)))
                      .then((value) => onRefresh()),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 52,
                    width: 52,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 0,
                          blurRadius: 7,
                          offset: Offset(0, 2),
                        )
                      ],
                    ),
                    child: Image.asset(
                      AppImages.fuel,
                      color: item.health == 1 ? Colors.grey : healthColor,
                    ),
                  ),
                  SizedBox(height: 7),
                  Text(FlutterI18n.translate(context, 'add')),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 16),
                child: CircularGraph(
                  item.health * 100,
                  item.health <= 0.1 ? healthColor : minerColor,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('${(item.health * 100).round()}%',
                          style: kSuperBigBoldFont),
                      Text(
                        FlutterI18n.translate(context, 'health_score'),
                        style: kMiddleFontOfGrey,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: item.miningFuel > Decimal.zero
                  ? () => Navigator.of(context)
                      .push(route((ctx) => SendToWalletPage(gatewayItem: item)))
                      .then((value) => onRefresh())
                  : null,
              child: Column(
                children: [
                  Container(
                    height: 52,
                    width: 52,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 0,
                          blurRadius: 7,
                          offset: Offset(0, 2),
                        )
                      ],
                    ),
                    child: Container(
                      child: Icon(
                        Icons.arrow_forward,
                        color: item.miningFuel > Decimal.zero
                            ? healthColor
                            : Colors.grey,
                        size: 26,
                      ),
                    ),
                  ),
                  SizedBox(height: 7),
                  Text(FlutterI18n.translate(context, 'send')),
                ],
              ),
            ),
            SizedBox(width: 16),
          ],
        ),
        SizedBox(height: 16),
        Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                AppImages.fuel,
                color: healthColor,
              ),
              SizedBox(width: 10),
              Text(
                '${Tools.priceFormat(item.miningFuel.toDouble())} / ${Tools.priceFormat(item.miningFuelMax.toDouble())} MXC',
                style: kBigFontOfBlack,
              )
            ],
          ),
        ),
        SizedBox(height: 16),
        StatisticTable(item: item),
        MinerDetailTitle(
          FlutterI18n.translate(context, 'uptime'),
          action: InkWell(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 6, vertical: 5),
              child: Text(
                FlutterI18n.translate(context, 'see_more'),
                style: kSmallFontOfDarkBlue,
              ),
            ),
            onTap: () => Navigator.of(context).push(route((ctx) => ViewAllPage(
                  minerId: item.id,
                  type: MinerStatsType.uptime,
                ))),
          ),
        ),
        GraphCard(
          online: DateTime.tryParse(item.lastSeenAt)
                  .difference(DateTime.now())
                  .abs() <
              Duration(minutes: 5),
          lastSeen: DateTime.tryParse(item.lastSeenAt),
          maxValue: 1,
          subtitle: FlutterI18n.translate(context, 'score_weekly_total'),
          title:
              '${(avgSecondsOnlinePerDay  / (24 * 60 * 60.0) * 100).round()}% (${(avgSecondsOnlinePerDay * (healthStatistics?.length ?? 0) / (60 * 60.0)).toInt()}h)',
          entities: healthStatistics?.map((e) => GraphEntity(e.date, e.onlineSeconds / (24 * 60 * 60.0)))?.toList(),
          startDate: healthStatistics?.first?.date,
          endDate: healthStatistics?.last?.date,
        ),
        SizedBox(height: 8),
        MinerDetailTitle(
          'GPS',
          action: InkWell(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 6, vertical: 5),
              child: Text(
                FlutterI18n.translate(context, 'view_map'),
                style: kSmallFontOfDarkBlue,
              ),
            ),
            onTap: () {},
          ),
        ),
        infoCard(
          image: Image.asset(AppImages.gps),
          value: 100,
          title: FlutterI18n.translate(context, 'gps_card_title'),
          description: FlutterI18n.translate(context, 'gps_card_description'),
          comment: FlutterI18n.translate(context, 'gps_card_comment'),
        ),
        SizedBox(height: 8),
        MinerDetailTitle(FlutterI18n.translate(context, 'altitude')),
        infoCard(
          image: Image.asset(AppImages.altitude),
          value: 100,
          title: FlutterI18n.translate(context, 'altitude_card_title'),
          description:
              FlutterI18n.translate(context, 'altitude_card_description')
                  .replaceAll('{0}', '5'),
          comment: FlutterI18n.translate(context, 'altitude_card_comment'),
        ),
        SizedBox(height: 8),
        MinerDetailTitle(FlutterI18n.translate(context, 'proximity')),
        infoCard(
          image: Image.asset(AppImages.proximity),
          value: 100,
          title: FlutterI18n.translate(context, 'proximity_card_title'),
          description:
              FlutterI18n.translate(context, 'proximity_card_description')
                  .replaceAll('{0}', '4'),
          comment: FlutterI18n.translate(context, 'proximity_card_comment'),
        ),
        SizedBox(height: 8),
        MinerDetailTitle(FlutterI18n.translate(context, 'orientation')),
        infoCard(
          image: Image.asset(AppImages.orientation),
          value: 100,
          title: FlutterI18n.translate(context, 'orientation_card_title'),
          description:
              FlutterI18n.translate(context, 'orientation_card_description')
                  .replaceAll('{0}', '0'),
          comment: FlutterI18n.translate(context, 'orientation_card_comment'),
        ),
        SizedBox(height: 30),
      ],
    );
  }
}

class StatisticTable extends StatelessWidget {
  final GatewayItem item;

  const StatisticTable({Key key, this.item}) : super(key: key);

  Widget _statisticItem(String title, String value) => Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: kSmallFontOfGrey,
            ),
            SizedBox(height: 8),
            Text(value, style: kBigFontOfDarkBlue,
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorMxc.withOpacity(0.05),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Row(
            children: [
              _statisticItem(
                FlutterI18n.translate(context, 'uptime'),
                '${((item.uptimeHealth ?? 0) * 100).round()}%',
              ),
              _statisticItem(FlutterI18n.translate(context, 'gps'), FlutterI18n.translate(context, 'coming')),
              _statisticItem(FlutterI18n.translate(context, 'altitude'), FlutterI18n.translate(context, 'coming')),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              _statisticItem(FlutterI18n.translate(context, 'proximity'), FlutterI18n.translate(context, 'coming')),
              _statisticItem(
                  FlutterI18n.translate(context, 'orientation'), FlutterI18n.translate(context, 'coming')),
              _statisticItem(
                FlutterI18n.translate(context, 'fuel'),
                '${((item.miningFuelHealth ?? 0) * 100).round()}%',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
