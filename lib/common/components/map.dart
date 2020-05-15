import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:supernodeapp/common/components/panel/panel_frame.dart';
import 'package:supernodeapp/common/configs/sys.dart';

import 'package:supernodeapp/theme/colors.dart';
import 'package:user_location/user_location.dart';

Widget map({ BuildContext context, LatLng center, double zoom = 12.0,
List<Marker> markers,MapController controller,Function(LatLng) onTap,Function callback,bool userLocationSwitch = false}) {

  StreamController<LatLng> markerlocationStream = StreamController();
  markerlocationStream.stream.listen((onData) {
    //print(onData.latitude);
  });

  UserLocationOptions userLocationOptions = UserLocationOptions(
    context: context,
    mapController: controller,
    fabBottom: 205,
    markers: markers,
    defaultZoom: 12,
    // zoomToCurrentLocationOnLoad: true,
    showMoveToCurrentLocationFloatingActionButton: userLocationSwitch,
    // markerWidget: Container(),
    onLocationUpdate: (LatLng location){
      if(callback != null){
        callback(location);
      }
    },
  );

  if(center != null && controller != null && controller.ready) {
    double currentZoom = controller.zoom;
    controller.move(center, currentZoom);
  }

  return panelFrame(
    height: 263,
    child: new FlutterMap(
      mapController: controller,
      options: MapOptions(
        center: center != null ? center : LatLng(22.08,113.49),
        zoom: zoom,
        onTap: onTap,
        plugins: [
          UserLocationPlugin(),
        ],
      ),
      layers: [
        TileLayerOptions(
          urlTemplate: "https://api.mapbox.com/styles/v1/mxcdatadash/ck9qr005y5xec1is8yu6i51kw/tiles/256/{z}/{x}/{y}@2x?access_token={accessToken}",
          additionalOptions: {
            'accessToken': Sys.mapToken,
            'id': 'mapbox.streets',
          },
        ),
        MarkerLayerOptions(
          markers: markers ?? [],
        ),
        userLocationOptions,
      ],
    ),
  );

}