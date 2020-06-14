import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:supernodeapp/common/components/map_box.dart';
import 'package:supernodeapp/common/components/widgets/component_widgets.dart';

import 'state.dart';

Widget buildView(mapboxState state, Dispatch dispatch, ViewService viewService) {

  return ScaffoldWidget(
    body: MapBoxWidget(
      // TODO: controller reducer
      onMapCreated: (ctl) => {},
      userLocationSwitch: true,
      markers: state.gatewaysLocations ?? [],
      isFullScreen: true,
      myLatLng: state.myLocation,
    ),
    useSafeArea: false,
  );
}
