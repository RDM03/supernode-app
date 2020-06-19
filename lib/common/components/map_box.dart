import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:supernodeapp/common/components/panel/panel_frame.dart';
import 'package:supernodeapp/common/configs/sys.dart';

class MapViewController {
  List<MapMarker> markers;
  MapboxMapController ctl;
  LatLng myLatLng;
  double zoom;

  MapViewController({this.markers, this.zoom = 12});

  void onMapCreated(MapboxMapController controller) {
    this.ctl = controller;
  }

  void addSymbol(MapMarker marker) {
    if (markers == null) markers = List<MapMarker>();
    var result = markers.where((MapMarker item) => (item.point.latitude == marker.point.latitude) && (item.point.longitude == item.point.longitude));
    if (result.isEmpty) {
      markers.add(marker);
    }
    ctl?.addSymbol(SymbolOptions(
      iconImage: marker.image,
      geometry: marker.point,
      iconSize: marker?.size ?? 1,
    ));
  }

  void addSymbols(List<MapMarker> markers) {
    for (MapMarker mark in markers ?? []) {
      addSymbol(mark);
    }
  }

  Future<void> moveToMyLatLng() async {
    if (myLatLng == null) myLatLng = await ctl.requestMyLocationLatLng();
    if (myLatLng != null) ctl.moveCamera(CameraUpdate.newLatLngZoom(myLatLng, zoom));
  }
}

class MapMarker {
  final LatLng point;
  final double size;
  final String image;
  bool onMap = false;

  MapMarker({this.point, this.size, this.image});
}

class MapBoxWidget extends StatefulWidget {
  final bool isFullScreen;
  final bool userLocationSwitch;
  final VoidCallback zoomOutCallback;
  final ValueChanged<LatLng> onTap;

  // new field
  final Function clickLocation;
  final MapViewController config;

  // delete field
//  final BuildContext context;

  const MapBoxWidget({
    Key key,
    @required this.config,
    this.onTap,
    this.zoomOutCallback,
    this.clickLocation,
    this.userLocationSwitch,
    this.isFullScreen = false,
  }) : super(key: key);

  @override
  _MapBoxWidgetState createState() => _MapBoxWidgetState();
}

class _MapBoxWidgetState extends State<MapBoxWidget> {
  bool _screenInit = false;
  MediaQueryData _mediaData;

  MapViewController get config => widget.config;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) async{
      await Future.delayed(Duration(milliseconds: 200));
      config.addSymbols(config.markers);
    });
  }

  void _screenQuery() {
    if (!_screenInit || _mediaData == null) {
      _mediaData = MediaQuery.of(context);
      _screenInit = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    _screenQuery();
    return widget.isFullScreen
        ? Container(
            child: _buildMapView(),
            width: _mediaData.size.width,
            height: _mediaData.size.height,
          )
        : panelFrame(height: 263, child: _buildMapView());
  }

  Widget _buildMapView() {
    return Stack(
      children: <Widget>[
        MapboxMap(
          initialCameraPosition: CameraPosition(target: LatLng(37.386, -122.083), zoom: config.zoom),
          myLocationEnabled: true,
          myLocationRenderMode: MyLocationRenderMode.NORMAL,
          myLocationTrackingMode: MyLocationTrackingMode.Tracking,
          styleString: Sys.mapTileStyle,
          compassEnabled: false,
          onMapClick: (point, coordinates) {
            widget.onTap(coordinates);
          },
          onMapCreated: config.onMapCreated,
          gestureRecognizers: !widget.isFullScreen
              ? <Factory<OneSequenceGestureRecognizer>>[
                  Factory<OneSequenceGestureRecognizer>(
                    () => ScaleGestureRecognizer(),
                  ),
                ].toSet()
              : null,
        ),
        _buildMyLocationIcon(),
        widget.isFullScreen ? _buildCloseIcon() : _buildZoomOutIcon(),
      ],
    );
  }

  Widget _buildMyLocationIcon() {
    return Positioned(
      bottom: widget.isFullScreen ? 20 + _mediaData.padding.bottom + 40 + 10 : 205,
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
          onPressed: config.moveToMyLatLng,
          icon: Icon(
            Icons.my_location,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildZoomOutIcon() {
    if (widget.zoomOutCallback == null) return SizedBox();
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
          onPressed: widget.zoomOutCallback,
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
      bottom: 20 + _mediaData.padding.bottom,
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
}
