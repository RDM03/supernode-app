import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mapbox_native/flutter_mapbox_native.dart';
import 'package:supernodeapp/common/components/mapbox_gl.dart';
import 'package:supernodeapp/configs/sys.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(MapboxGlState state, Dispatch dispatch, ViewService viewService) {
  return FutureBuilder(
    builder: (context,builder) {
      return new FlutterMapboxNative(
        mapStyle: Sys.mapTileStyle,
        center: CenterPosition(
          target: LatLng(0,0),
          zoom: 12,
          animated: true,
        ),
        // minimumZoomLevel: 1,
        maximumZoomLevel: 12, 
        clusters: state.geojsonList,
        myLocationEnabled: true,
        myLocationTrackingMode: MyLocationTrackingMode.Tracking,
        isFullScreen: false,
        onFullScreenTap: () => Navigator.of(viewService.context).pop()
      );
    }
  );
}
