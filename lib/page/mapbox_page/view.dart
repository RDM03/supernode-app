import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:supernodeapp/common/components/map_box.dart';
import 'package:supernodeapp/common/components/widgets/component_widgets.dart';

import 'state.dart';

Widget buildView(MapBoxState state, Dispatch dispatch, ViewService viewService) {
  return ScaffoldWidget(
    body: MapBoxWidget(
      config: state.mapCtl,
      userLocationSwitch: true,
      isFullScreen: true,
    ),
    useSafeArea: false,
  );
}
