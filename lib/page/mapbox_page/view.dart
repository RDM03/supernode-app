import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:supernodeapp/common/components/map.dart';
import 'package:supernodeapp/common/components/widgets/component_widgets.dart';
import 'state.dart';

Widget buildView(mapboxState state, Dispatch dispatch, ViewService viewService) {
  final _ctx = viewService.context;

  return ScaffoldWidget(
    body: map(
      context: _ctx,
      userLocationSwitch: true,
      center: state.gatewaysLocations.isNotEmpty ? state.gatewaysLocations.first.point : null,
      markers: state.gatewaysLocations ?? [],
      controller: state.mapCtl,
      isFullScreen: true,
    ),
    useSafeArea: false,
  );
}
