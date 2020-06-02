import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:supernodeapp/common/components/panel/panel_frame.dart';
import 'package:supernodeapp/common/configs/sys.dart';

import 'package:user_location/user_location.dart';
import 'package:location/location.dart';

Widget map({
  BuildContext context,
  double zoom = 12.0,
  List<Marker> markers,
  MapController controller,
  ValueChanged<LatLng> onTap,
  Function callback,
  bool userLocationSwitch = false,
  VoidCallback zoomOutCallback,
  bool isFullScreen = false,
  LocationData myLocationData,
}) {
  final mediaQueryData = MediaQuery.of(context);
  
  if (myLocationData != null && controller != null && !isFullScreen) {
    controller.move(LatLng(myLocationData?.latitude, myLocationData?.longitude), zoom);
  }

  Widget _buildMyLocationIcon() {
    return Positioned(
      bottom: isFullScreen ? 20 + mediaQueryData.padding.bottom + 40 + 10 : 205,
      right: 20,
      width: 40,
      height: 40,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blueAccent,
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 10.0)],
        ),
        child: IconButton(
          onPressed: () {
            if (myLocationData != null) {
              controller.move(LatLng(myLocationData?.latitude, myLocationData?.longitude), zoom);
            }
          },
          icon: Icon(
            Icons.my_location,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildZoomOutIcon() {
    if (zoomOutCallback == null) return SizedBox();
    return Positioned(
      bottom: 155,
      right: 20,
      width: 40,
      height: 40,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blueAccent,
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 10.0)],
        ),
        child: IconButton(
          onPressed: zoomOutCallback,
          icon: Icon(
            Icons.zoom_out_map,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildCloseIcon() {
    return Positioned(
      bottom: 20 + mediaQueryData.padding.bottom,
      right: 20,
      width: 40,
      height: 40,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blueAccent,
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 10.0)],
        ),
        child: IconButton(
          onPressed: () {
            if (Navigator.of(context).canPop()) {
              Navigator.of(context).pop();
            }
          },
          icon: Icon(
            Icons.close,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildFlutterMap() {
    return Stack(
      children: <Widget>[
        FlutterMap(
          mapController: controller,
          options: MapOptions(
            center: myLocationData == null
                ? LatLng(0, 0)
                : LatLng(myLocationData?.latitude, myLocationData?.longitude),
            zoom: zoom,
            onTap: onTap,
            plugins: [
//              UserLocationPlugin(),
            ],
          ),
          layers: [
            TileLayerOptions(
              urlTemplate: Sys.mapUrlTemplate,
              additionalOptions: {
                'accessToken': Sys.mapToken,
                'id': 'mapbox.streets',
              },
              tileProvider: NonCachingNetworkTileProvider(),
            ),
            MarkerLayerOptions(markers: markers),
          ],
        ),
        _buildMyLocationIcon(),
        isFullScreen ? _buildCloseIcon() : _buildZoomOutIcon(),
      ],
    );
  }

  return isFullScreen
      ? Container(
          height: mediaQueryData.size.height,
          child: _buildFlutterMap(),
        )
      : panelFrame(
          height: 263,
          child: _buildFlutterMap(),
        );
}
