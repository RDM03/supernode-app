import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:supernodeapp/common/components/permission_utils.dart';
import 'package:supernodeapp/common/utils/map_html.dart';
import 'package:supernodeapp/configs/sys.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MapBoxGLWidget extends StatefulWidget {
  final List markers;
  final bool isFullScreen;
  final bool userLocationSwitch;
  final Function onFullScreenPress;

  const MapBoxGLWidget({
    Key key,
    this.markers,
    this.isFullScreen = false,
    this.userLocationSwitch = true,
    this.onFullScreenPress
  }) : super(key: key);

  @override
  _MapBoxGLState createState() => _MapBoxGLState();
}

class _MapBoxGLState extends State<MapBoxGLWidget> {
  WebViewController _controller;
  bool _myLocationEnable = true;
  List _oldMarkers = [];

  @override
  void initState() {
    super.initState();
    
    _addToMyLocation();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.resumed:
        // if(mounted && _controller != null){
        //   _controller.reload().then((value){
        //     Future.delayed(Duration(seconds: 2),(){
        //       _initMap();
        //     });
        //   });
        // }
        break;
      case AppLifecycleState.paused:
        break;
      case AppLifecycleState.detached:
        break;
    }
  }

  // @override
  // void dispose() {
  //   // WidgetsBinding.instance.removeObserver(this);
  //   super.dispose();
  // }

  @override
  void didUpdateWidget(MapBoxGLWidget oldWidget) {
    _setMarkers(oldWidget);
    
    super.didUpdateWidget(oldWidget);
  }

  void _initMap(){
    DefaultAssetBundle.of(context)
      .loadString(Sys.mapboxjs)
      .then((String mapboxjs) async{
        _controller.evaluateJavascript(mapboxjs);
      })
      .then((_) {
        _controller.evaluateJavascript(map_html).then((_) async{

          Future.delayed(Duration(seconds: 1),(){
            DefaultAssetBundle.of(context)
              .loadString(Sys.mapjs)
              .then((String mapjs) async{
                // GatewaysLocationDao gatewayLocations = GatewaysLocationDao();
                // List features = await gatewayLocations.listFromLocal();
                // String featuresJson = json.encode(features);

                // RegExp role = new RegExp(r'__s\d__');
                // String newJS = js.replaceAllMapped(role, (match){
                //   if(match.group(0) == '__s1__'){
                //     return featuresJson;
                //   }
                // });

                _controller.evaluateJavascript(mapjs).then((_) async{
                  _addMarkers(widget.markers);
                  _moveToMyLocation();
                });
              });
          });
        });
      });
  }

  void _setMarkers(MapBoxGLWidget oldWidget){
    
    if (widget.markers.isNotEmpty && _oldMarkers.length != widget.markers.length) {
      _oldMarkers = widget.markers;
      setState(() {});
      //The first time, the web have not loaded the file of map's js,it will be lead to fail or error.
      //So it make to delay for 2 seconds.
      Future.delayed(Duration(seconds: 2),(){
        _addMarkers(widget.markers);
      });
    }

  }

  void _moveToMyLocation({int seconds = 2}) async{
    bool isPermiss = await PermissionUtil.getLocationPermission();

    if (mounted && isPermiss) {
      Future.delayed(Duration(seconds: seconds,), () async{
        if(_controller != null){
          Position position = await getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
          await _controller.evaluateJavascript('window.addMyLocation(${position.longitude},${position.latitude},true);');
        }
      });
    }
  }

  Future<void> _removeMyLocation() async{
    await _controller.evaluateJavascript('window.removeMyLocation();');
  }

  Future<void> _addToMyLocation({int seconds = 0}) async{
    bool isPermiss = await PermissionUtil.getLocationPermission();

    if (mounted && isPermiss) {
      Future.delayed(Duration(seconds: seconds,), () async{
        if(_controller != null){
          Position position = await getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
          await _controller.evaluateJavascript('window.addMyLocation(${position.longitude},${position.latitude},true);');
        }
      });
    }
  }

  Future<void> _setMyLocationEnable({bool state}) async {
    bool has = await PermissionUtil.getLocationPermission();
    setState(() {
      _myLocationEnable = has ? (state ?? true) : false;
    });
  }

  Future<void> _removeMarkers() async{
    await _controller.evaluateJavascript('window.gatewaysFeatures = [];');
    await _controller.evaluateJavascript('window.removeClusters();');
  }

  Future<void> _addMarkers(List markers) async{
    _removeMarkers();
    
    String featuresJson = json.encode(markers);
    await _controller.evaluateJavascript('window.gatewaysFeatures = $featuresJson;');
    await _controller.evaluateJavascript('window.addClusters();');
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Stack(
        children: <Widget>[
          WebView(
            initialUrl: 'about:blank',
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController controller) {
              _controller = controller;
              setState(() {});

              _initMap();
            },
            onPageFinished: (String url) {

            },
            javascriptChannels: <JavascriptChannel>[
              _javascriptChannel(context)
            ].toSet()
          ),
          _buildActionWidgets()
        ],
      )
    );
  }

  JavascriptChannel _javascriptChannel(BuildContext context) {
		return JavascriptChannel(
			name: 'MapBrowser',
			onMessageReceived: (JavascriptMessage msg) {
        print(msg.message);
			}
		);
	}

  Widget _buildActionWidgets() {
    return Positioned(
      bottom: 60,
      right: 20,
      child: Column(
        children: <Widget>[
          _buildMyLocationIcon(),
          _buildRefreshIcon(),
          _buildMyLocationStateChange(),
          _buildCloseAndFullScreenIcon(widget.isFullScreen)
        ],
      ),
    );
  }

  Widget _buildMyLocationIcon() {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 10.0)],
      ),
      child: IconButton(
        onPressed: () => _moveToMyLocation(),
        icon: Icon(
          Icons.my_location,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildRefreshIcon() {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 10.0)],
      ),
      child: IconButton(
        onPressed: () => _initMap(),
        icon: Icon(
          Icons.refresh,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildMyLocationStateChange() {
    if (!widget.userLocationSwitch) {
      return SizedBox();
    }
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 10.0)],
      ),
      child: IconButton(
        onPressed: () async {
          _setMyLocationEnable(state: !_myLocationEnable);
          if(_myLocationEnable){
            await _removeMyLocation();
          }else{
            await _addToMyLocation();
          }
        },
        icon: Icon(
          _myLocationEnable ? Icons.location_off : Icons.location_on,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildCloseAndFullScreenIcon(bool isFullScreen) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 10.0)],
      ),
      child: IconButton(
        onPressed: () {
          if(isFullScreen){
            if(Navigator.of(context).canPop()) {
              Navigator.of(context).pop();
            }
          }else{
            if(widget.onFullScreenPress != null){
              widget.onFullScreenPress();
            }
          }
        },
        icon: Icon(
          isFullScreen ? Icons.close : Icons.zoom_out_map,
          color: Colors.white,
        ),
      ),
    );
  }

}