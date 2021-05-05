import 'dart:math';

import 'package:fish_redux/fish_redux.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:supernodeapp/common/components/map_box.dart';
import 'package:supernodeapp/common/components/page/introduction.dart';
import 'package:supernodeapp/common/components/page/page_frame.dart';
import 'package:supernodeapp/common/components/page/page_nav_bar.dart';
import 'package:supernodeapp/common/components/page/paragraph.dart';
import 'package:supernodeapp/common/components/picker/ios_style_bottom_dailog.dart';
import 'package:supernodeapp/common/utils/gateway.dart';
import 'package:supernodeapp/common/utils/screen_util.dart';
import 'package:supernodeapp/common/utils/time.dart';
import 'package:supernodeapp/configs/images.dart';
import 'package:supernodeapp/page/home_page/bloc/supernode/gateway/state.dart';
import 'package:supernodeapp/theme/font.dart';
import 'package:supernodeapp/theme/spacing.dart';

import 'state.dart';

Widget buildView(
    GatewayProfileState state, Dispatch dispatch, ViewService viewService) {
  var _ctx = viewService.context;
  GatewayItem profile = state.profile;
  final location = LatLng((profile.location['latitude'] as num).toDouble(),
      (profile.location['longitude'] as num).toDouble());

  return pageFrame(context: viewService.context, children: [
    pageNavBar(profile.name, onTap: () => Navigator.pop(viewService.context)),
    ListTile(
        contentPadding: kOuterRowTop20,
        title: Row(
          children: [
            Text(
              '${FlutterI18n.translate(_ctx, 'downlink_price')}',
              style: kBigFontOfBlack,
            ),
            GestureDetector(
              onTap: () => _showInfoDialog(viewService.context),
              child: Padding(
                key: Key("questionCircle"),
                padding: EdgeInsets.all(s(5)),
                child: Image.asset(AppImages.questionCircle, height: s(20)),
              ),
            )
          ],
        ),
        trailing: Container(
          margin: const EdgeInsets.only(top: 5),
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
          decoration: BoxDecoration(
            color: Color.fromARGB(51, 77, 137, 229),
            borderRadius: BorderRadius.all(Radius.circular(7)),
          ),
          child: Text(
            '${profile.location["accuracy"]} MXC',
            style: kBigFontOfBlack,
          ),
        )),
    MapBoxWidget(
      key: ValueKey('minerDetailsMapbox'),
      rowTop: EdgeInsets.zero,
      config: state.mapCtl,
      centerLocation: location,
      userLocationSwitch: false,
      isUserLocation: false,
      isUserLocationSwitch: false,
    ),
    ListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(
          '${profile.location['altitude']} meters',
          key: ValueKey('minerDetailsAltitude'),
          style: kMiddleFontOfGrey,
        ),
        trailing: Text(
          '${profile.location['latitude']},${profile.location['longitude']}',
          key: ValueKey('minerDetailsCoordinates'),
          style: kMiddleFontOfGrey,
        )),
    paragraph(FlutterI18n.translate(_ctx, 'gateway_id')),
    introduction(profile.id ?? '',
        key: ValueKey('minerDetailsMinerId'), top: 5),
    paragraph(FlutterI18n.translate(_ctx, 'last_seen')),
    introduction(TimeUtil.getDatetime(profile.lastSeenAt) ?? '',
        key: ValueKey('minerDetailsLastSeen'), top: 5),
    Padding(
      padding: kOuterRowTop35,
      child: paragraph(FlutterI18n.translate(_ctx, 'weekly_revenue')),
    ),
    Center(
      child: Container(
        width: 300,
        height: 300,
        child: MiningChart(
          state.miningRevenve,
          key: ValueKey('miningChart'),
        ),
      ),
    ),
    paragraph(FlutterI18n.translate(_ctx, 'frame')),
    Center(
      child: Container(
        width: 300,
        height: 300,
        child: FrameChart(source: state.gatewayFrame),
      ),
    ),
    paragraph(FlutterI18n.translate(_ctx, 'gateway_model')),
    introduction(profile.model ?? '',
        key: ValueKey('minerDetailsMinerModel'), top: 5),
    paragraph(FlutterI18n.translate(_ctx, 'gateway_osversion')),
    introduction(profile.osversion ?? '',
        key: ValueKey('minerDetailsMinerOS'), top: 5),
  ]);
}

class FrameChart extends StatelessWidget {
  final List source;

  const FrameChart({Key key, this.source}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data = GatewayFrame.mapData(source);
    return Column(
      children: [
        Row(
          children: [
            SizedBox(width: 40),
            Container(
              width: 10,
              height: 10,
              color: Colors.blue,
            ),
            SizedBox(width: 10),
            Text('Transmitted'),
            SizedBox(width: 25),
            Container(
              width: 10,
              height: 10,
              color: Colors.green,
            ),
            SizedBox(width: 10),
            Text('Received'),
          ],
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: BarChart(
              BarChartData(
                barGroups: data.entries
                    .map(
                      (entry) => BarChartGroupData(
                        x: entry.key.millisecondsSinceEpoch,
                        barRods: [
                          BarChartRodData(
                            y: entry.value.transmitted,
                            colors: [Colors.blue],
                            width: 70 / data.length,
                            borderRadius: BorderRadius.zero,
                          ),
                          BarChartRodData(
                            y: entry.value.received,
                            colors: [Colors.green],
                            width: 70 / data.length,
                            borderRadius: BorderRadius.zero,
                          ),
                        ],
                      ),
                    )
                    .toList(),
                gridData: FlGridData(
                  horizontalInterval: 5,
                ),
                borderData: FlBorderData(border: Border(bottom: BorderSide())),
                titlesData: FlTitlesData(
                  bottomTitles: SideTitles(
                    showTitles: true,
                    getTitles: (d) {
                      final date =
                          DateTime.fromMillisecondsSinceEpoch(d.round());
                      return '${date.day}/${date.month}';
                    },
                  ),
                  leftTitles: SideTitles(
                    showTitles: true,
                    interval: 5,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class MiningChart extends StatelessWidget {
  final List miningRevenue;
  MiningChart(this.miningRevenue, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data = Mining.mapData(miningRevenue);
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: LineChart(
        LineChartData(
          minY: 0,
          maxY:
              (data.map((e) => e.amount).reduce(max) / 250).ceil() * 250.0 + 1,
          titlesData: FlTitlesData(
            bottomTitles: SideTitles(
              showTitles: true,
              interval: 172800000,
              getTitles: (d) {
                final date = DateTime.fromMillisecondsSinceEpoch(d.round());
                return '${date.day}/${date.month}';
              },
            ),
            leftTitles: SideTitles(
              showTitles: true,
              interval: 250,
            ),
          ),
          gridData: FlGridData(
            horizontalInterval: 100,
          ),
          borderData: FlBorderData(border: Border(bottom: BorderSide())),
          lineBarsData: [
            LineChartBarData(
              spots: data
                  .map((e) => FlSpot(
                      e.date.millisecondsSinceEpoch.toDouble(), e.amount))
                  .toList(),
              colors: [Colors.green],
            ),
          ],
        ),
        swapAnimationDuration: Duration(milliseconds: 200),
      ),
    );
  }
}

void _showInfoDialog(BuildContext context) {
  showInfoDialog(
    context,
    IosStyleBottomDialog2(
      builder: (context) => Column(
        children: [
          Image.asset(AppImages.infoDownlinkPrice, height: s(80)),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Text(
                FlutterI18n.translate(context, 'info_downlink_price'),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: s(16),
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              )),
        ],
      ),
    ),
  );
}
