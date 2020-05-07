import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/app_bars/home_bar.dart';
import 'package:supernodeapp/common/components/empty.dart';
import 'package:supernodeapp/common/components/page/page_body.dart';
import 'package:supernodeapp/common/components/panel/panel_body.dart';
import 'package:supernodeapp/common/components/panel/panel_frame.dart';

import '../action.dart';
import 'action.dart';
import 'state.dart';

Widget buildView(GatewayState state, Dispatch dispatch, ViewService viewService) {
  var _ctx = viewService.context;
  final ListAdapter adapter = viewService.buildAdapter();

  return Scaffold(
    appBar: homeBar(
      FlutterI18n.translate(_ctx,'total_gateways'),
      onPressed: () => dispatch(HomeActionCreator.onSettings()),
    ),
    body: pageBody(
      children: [
        panelFrame(
          child: panelBody(
            icon: Icons.add_circle,
            onPressed: () => dispatch(GatewayActionCreator.onAdd()),
            titleText: FlutterI18n.translate(_ctx,'total_gateways'),
            subtitleText: '${state.gatewaysTotal}',
            trailTitle: FlutterI18n.translate(_ctx,'revenue'),
            trailSubtitle: '${state.gatewaysRevenue} MXC (${state.gatewaysUSDRevenue} USD)'
          )
        ),
        panelFrame(
          child: adapter.itemCount != 0 ? 
          ListView.builder(
            itemBuilder: adapter.itemBuilder,
            itemCount: adapter.itemCount,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
          ) :
          empty(_ctx)
        )
      ]
    )
  );
}
