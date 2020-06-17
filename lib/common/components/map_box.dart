import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:supernodeapp/common/components/panel/panel_frame.dart';

class MapMarker {
  final LatLng point;
  final double size;
  final String image;

  MapMarker({this.point, this.size, this.image});
}

class MapBoxWidget extends StatefulWidget {
  final bool isFullScreen;
  final double zoom;
  final List<MapMarker> markers;
  final VoidCallback zoomOutCallback;
  final ValueChanged<LatLng> onTap;
  final bool userLocationSwitch;

  // new field
  final Function clickLocation;
  final MapCreatedCallback onMapCreated;
  final bool myLocationEnabled;
  final MyLocationTrackingMode myLocationTrackingMode;

  // delete field
//  final BuildContext context;

  const MapBoxWidget({
    Key key,
    @required this.onMapCreated,
    this.zoom = 12.0,
    this.markers,
    this.onTap,
    this.zoomOutCallback,
    this.isFullScreen = false,
    this.clickLocation,
    this.userLocationSwitch,
    this.myLocationEnabled = true,
    this.myLocationTrackingMode = MyLocationTrackingMode.Tracking, // not use
  }) : super(key: key);

  @override
  _MapBoxWidgetState createState() => _MapBoxWidgetState();
}

class _MapBoxWidgetState extends State<MapBoxWidget> {
  bool _screenInit = false;
  MediaQueryData _mediaData;
  MapboxMapController _controller;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {});
  }

  void _screenQuery() {
    if (!_screenInit || _mediaData == null) {
      _mediaData = MediaQuery.of(context);
      _screenInit = true;
    }
  }

  void _mapCreated(MapboxMapController controller) {
    _controller = controller;
    for (MapMarker mark in widget?.markers ?? []) {
      _controller.addSymbol(SymbolOptions(
        iconImage: mark.image,
        geometry: mark.point,
        iconSize: mark.size,
      ));
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
          initialCameraPosition: CameraPosition(target: LatLng(37.386, -122.083), zoom: widget.zoom),
          myLocationEnabled: widget.myLocationEnabled,
          myLocationRenderMode: MyLocationRenderMode.NORMAL,
          myLocationTrackingMode: widget.myLocationTrackingMode,
          onMapClick: (point, coordinates) {
            widget.onTap(coordinates);
          },
          onMapCreated: (controller) {
            widget.onMapCreated(controller);
            _mapCreated(controller);
          },
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
          onPressed: () async {
            LatLng myLatLng = await _controller.requestMyLocationLatLng();
            _controller.moveCamera(CameraUpdate.newLatLngZoom(myLatLng, widget.zoom));
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
