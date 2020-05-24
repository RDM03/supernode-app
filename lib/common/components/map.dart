import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:supernodeapp/common/components/panel/panel_frame.dart';
import 'package:supernodeapp/common/configs/sys.dart';
import 'package:user_location/user_location.dart';

Widget map({
  BuildContext context,
  LatLng center,
  double zoom = 12.0,
  List<Marker> markers,
  MapController controller,
  ValueChanged<LatLng> onTap,
  Function callback,
  bool userLocationSwitch = false,
  VoidCallback zoomOutCallback,
  bool isFullScreen = false,
}) {
  final mediaQueryData = MediaQuery.of(context);

  List<Marker> newMarkers = [];
  if (markers != null && markers.isNotEmpty) {
    final userLocation = markers.firstWhere(
      (v) => v.runtimeType == UserLocationMarker,
      orElse: () => null,
    );

    final subList = markers.takeWhile((v) => v.runtimeType != UserLocationMarker).toList();

    if (subList != null && subList.isNotEmpty) {
      newMarkers.addAll(subList);
    }
    if (userLocation != null) {
      newMarkers.add(userLocation);
    }

    print('newMarkers = $newMarkers');
  }

  List<Marker> list = newMarkers.isNotEmpty ? newMarkers : markers;
  UserLocationOptions userLocationOptions = UserLocationOptions(
    context: context,
    mapController: controller,
    fabBottom: isFullScreen ? 20 + mediaQueryData.padding.bottom : 205,
    markers: list,
    defaultZoom: 12,
    // zoomToCurrentLocationOnLoad: true,
    showMoveToCurrentLocationFloatingActionButton: userLocationSwitch,
    // markerWidget: Container(),
    onLocationUpdate: (LatLng location) {
      if (callback != null) {
        callback(location);
      }
    },
  );

  Widget _buildZoomOutIcon() {
    if (zoomOutCallback == null) return SizedBox();
    return Positioned(
      top: 10,
      left: 10,
      width: 30,
      height: 30,
      child: IconButton(
        onPressed: zoomOutCallback,
        icon: Icon(
          Icons.zoom_out_map,
          color: Colors.blue,
          size: 30,
        ),
      ),
    );
  }

  Widget _buildCloseIcon() {
    return Positioned(
      bottom: 60,
      left: 10,
      width: 30,
      height: 30,
      child: IconButton(
        onPressed: () {
          if (Navigator.of(context).canPop()) {
            Navigator.of(context).pop();
          }
        },
        icon: Icon(
          Icons.close,
          color: Colors.blue,
          size: 30,
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
            center: LatLng(0, 0),
            zoom: zoom,
            onTap: onTap,
            plugins: [
              UserLocationPlugin(),
            ],
          ),
          layers: [
            TileLayerOptions(
              urlTemplate: Sys.mapUrlTemplate,
              additionalOptions: {
                'accessToken': Sys.mapToken,
                'id': 'mapbox.streets',
              },
            ),
            MarkerLayerOptions(markers: list),
            userLocationOptions,
          ],
        ),
        isFullScreen ? _buildCloseIcon() : _buildZoomOutIcon(),
      ],
    );
  }

  return isFullScreen
      ? Container(
          height: mediaQueryData.size.height - mediaQueryData.padding.top,
          child: _buildFlutterMap(),
        )
      : panelFrame(
          height: 263,
          child: _buildFlutterMap(),
        );
}
