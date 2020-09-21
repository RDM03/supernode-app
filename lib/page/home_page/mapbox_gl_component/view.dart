import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:supernodeapp/common/components/map_box.dart';
import 'package:supernodeapp/common/components/mapbox_gl.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(MapboxGlState state, Dispatch dispatch, ViewService viewService) {
  return MapBoxWidget(
    isFullScreen: true,
    config: MapViewController(
    ),
  );
}
