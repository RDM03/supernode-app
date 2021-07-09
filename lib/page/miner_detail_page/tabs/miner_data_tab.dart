import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/repositories/supernode/dao/gateways.model.dart';
import 'package:supernodeapp/common/utils/utils.dart';
import 'package:supernodeapp/page/home_page/bloc/supernode/gateway/state.dart';
import 'package:supernodeapp/page/home_page/gateway/view_all_page/bloc/state.dart';
import 'package:supernodeapp/page/home_page/gateway/view_all_page/view.dart';
import 'package:supernodeapp/route.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/font.dart';

import '../graph_card.dart';
import '../title.dart';

class MinerDataTab extends StatelessWidget {
  final GatewayItem item;
  final List<GatewayStatisticResponse> framesData;
  final double downlinkPrice;

  const MinerDataTab({
    Key key,
    this.item,
    this.framesData,
    this.downlinkPrice,
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
            color: colorMxc.withOpacity(0.05),
            borderRadius: BorderRadius.circular(10),
          ),
          width: double.infinity,
          height: 80,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${Tools.priceFormat(downlinkPrice)} MXC',
                style: kVeryBigFontOfBlack,
              ),
              Text(
                FlutterI18n.translate(context, 'downlink_price'),
                style: kSmallFontOfGrey,
              )
            ],
          ),
        ),
        SizedBox(height: 16),
        MinerDetailTitle(
          FlutterI18n.translate(context, 'frame_received'),
          action: InkWell(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 6, vertical: 5),
              child: Text(
                FlutterI18n.translate(context, 'see_more'),
                style: kSmallFontOfDarkBlue,
              ),
            ),
            onTap: () => Navigator.of(context).push(
              routeWidget(
                ViewAllPage(
                  minerId: item.id,
                  type: MinerStatsType.frameReceived,
                ),
              ),
            ),
          ),
        ),
        GraphCard(
          startDate: framesData?.first?.timestamp,
          endDate: framesData?.last?.timestamp,
          subtitle: FlutterI18n.translate(context, 'weekly_packet'),
          title: framesData
                  ?.fold<int>(0, (source, v) => source + v.rxPacketsReceivedOK)
                  ?.toString() ??
              '...',
          entities: framesData
              ?.map((e) => GraphEntity(e.timestamp, e.rxPacketsReceivedOK))
              ?.toList(),
        ),
        SizedBox(height: 16),
        MinerDetailTitle(
          FlutterI18n.translate(context, 'frame_transmitted'),
          action: InkWell(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 6, vertical: 5),
              child: Text(
                FlutterI18n.translate(context, 'see_more'),
                style: kSmallFontOfDarkBlue,
              ),
            ),
            onTap: () => Navigator.of(context).push(
              routeWidget(
                ViewAllPage(
                  minerId: item.id,
                  type: MinerStatsType.frameTransmitted,
                ),
              ),
            ),
          ),
        ),
        GraphCard(
          startDate: framesData?.first?.timestamp,
          endDate: framesData?.last?.timestamp,
          subtitle: FlutterI18n.translate(context, 'weekly_packet'),
          title: framesData
                  ?.fold<int>(0, (source, v) => source + v.txPacketsEmitted)
                  ?.toString() ??
              '...',
          entities: framesData
              ?.map((e) => GraphEntity(e.timestamp, e.txPacketsEmitted))
              ?.toList(),
        ),
        SizedBox(height: 16),
        Center(
          child: Text(item.name ?? ''),
        ),
        SizedBox(height: 2),
        Center(
          child: Text(
            '${item.id ?? ''} / OS ${item.osversion ?? '???'}',
            style: kSmallFontOfGrey,
          ),
        ),
        SizedBox(height: 32),
      ],
    );
  }
}
