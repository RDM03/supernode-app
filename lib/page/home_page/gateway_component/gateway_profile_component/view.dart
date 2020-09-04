import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:supernodeapp/common/components/gateways/bar_char.dart';
import 'package:supernodeapp/common/components/gateways/line_chart.dart';
import 'package:supernodeapp/common/components/map_box.dart';
import 'package:supernodeapp/common/components/page/introduction.dart';
import 'package:supernodeapp/common/components/page/page_frame.dart';
import 'package:supernodeapp/common/components/page/page_nav_bar.dart';
import 'package:supernodeapp/common/components/page/paragraph.dart';
import 'package:supernodeapp/common/daos/chart_dao.dart';
import 'package:supernodeapp/common/daos/time_dao.dart';
import 'package:supernodeapp/page/home_page/gateway_component/gateway_list_adapter/gateway_item_component/state.dart';
import 'package:supernodeapp/theme/font.dart';
import 'package:supernodeapp/theme/spacing.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import 'action.dart';
import 'state.dart';

Widget buildView(
    GatewayProfileState state, Dispatch dispatch, ViewService viewService) {
  var _ctx = viewService.context;
  GatewayItemState profile = state.profile;
  final location = LatLng((profile.location['latitude'] as num).toDouble(),
      (profile.location['longitude'] as num).toDouble());

  return pageFrame(context: viewService.context, children: [
    pageNavBar(profile.name, onTap: () => Navigator.pop(viewService.context)),
    ListTile(
        contentPadding: kOuterRowTop20,
        title: Text(
          '${FlutterI18n.translate(_ctx, 'downlink_price')}',
          style: kBigFontOfBlack,
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
          style: kMiddleFontOfGrey,
        ),
        trailing: Text(
          '${profile.location['latitude']},${profile.location['longitude']}',
          style: kMiddleFontOfGrey,
        )),
    paragraph(FlutterI18n.translate(_ctx, 'gateway_id')),
    introduction(profile.id ?? '', top: 5),
    paragraph(FlutterI18n.translate(_ctx, 'last_seen')),
    introduction(TimeDao.getDatetime(profile.lastSeenAt) ?? '', top: 5),
    Padding(
      padding: kOuterRowTop35,
      child: paragraph(FlutterI18n.translate(_ctx, 'weekly_revenue')),
    ),
    Center(
      child: Container(
        width: 300,
        height: 300,
        child: charts.TimeSeriesChart(
          Mining.getData(state.miningRevenve),
          animate: true,
          defaultRenderer: charts.LineRendererConfig(includePoints: true),
        ),
      ),
    ),
    paragraph(FlutterI18n.translate(_ctx, 'frame')),
    Center(
      child: Container(
        width: 300,
        height: 300,
        child: charts.BarChart(
          GatewayFrame.getData(state.gatewayFrame),
          animate: true,
          barGroupingType: charts.BarGroupingType.grouped,
          behaviors: [new charts.SeriesLegend()],
        ),
      ),
    ),
    paragraph(FlutterI18n.translate(_ctx, 'gateway_model')),
    introduction(profile.model ?? '', top: 5),
    paragraph(FlutterI18n.translate(_ctx, 'gateway_osversion')),
    introduction(profile.osversion ?? '', top: 5),
  ]);
}
