import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:location/location.dart';
import 'package:supernodeapp/common/components/panel/panel_frame.dart';
import 'package:supernodeapp/common/utils/location.dart';
import 'package:supernodeapp/theme/colors.dart';

Widget map({ BuildContext context, LatLng center, double zoom = 12.0,
List<Marker> markers,MapController controller,Function(LatLng) onTap,Function callback,bool userLocationSwitch = false,Function onUserLocation}) {

  // StreamController<LatLng> markerlocationStream = StreamController();
  // markerlocationStream.stream.listen((onData) {
  //   print(onData.latitude);
  // });
  
  // UserLocationOptions userLocationOptions = UserLocationOptions(
  //   context: context,
  //   mapController: controller,
  //   fabBottom: 200,
  //   markers: [],
  //   defaultZoom: 12,
  //   // zoomToCurrentLocationOnLoad: true,
  //   showMoveToCurrentLocationFloatingActionButton: userLocationSwitch,
  //   // markerWidget: Container(),
  //   onLocationUpdate: (LatLng location){
  //     print('onLocationUpdate: ${location.longitude}');
  //   },
  // );
 
  Future<void> currentPosition() async{
    Location location = await userLocation();
    if(location == null) return;
    // LocationData locationData = await Location().getLocation();

    // LatLng currentLocation = LatLng(locationData.latitude,locationData.longitude);
    // controller.move(currentLocation,zoom);

    location.onLocationChanged.listen((locationData){
      LatLng currentLocation = LatLng(locationData.latitude,locationData.longitude);
      controller.move(currentLocation,zoom);

      if(callback != null){
        callback(currentLocation);
      }
    });
  
  }
  
  if(center != null && controller != null && controller.ready) {
    controller.move(center, zoom);
  }else{
    currentPosition();
  }

  return panelFrame(
    height: 263,
    child: Stack(
      children: <Widget>[
        FlutterMap(
          mapController: controller,
          options: MapOptions(
            center: center,
            zoom: zoom,
            // plugins: [
            //   UserLocationPlugin()
            // ],
            onTap: onTap,
          ),
          layers: [
            TileLayerOptions(
              urlTemplate: "https://api.tiles.mapbox.com/v4/"
            "{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}",
            additionalOptions: {
              'accessToken': 'pk.eyJ1IjoibXhjZGF0YWRhc2giLCJhIjoiY2s5bnc4dmh4MDBiMDNnbnczamRoN2ExeCJ9.sq0w8DGDXpA_6AMoejYaUw',
              'id': 'mapbox.streets',
            },
            //'http://a.tile.openstreetmap.fr/hot/{z}/{x}/{y}.png',//"https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              // subdomains: ['a', 'b', 'c'],
            ),
            MarkerLayerOptions(
              markers: markers ?? [],
            ),
            // userLocationOptions
          ],
        ),
        Positioned(
          top: 10,
          right: 10,
          child: Visibility(
            visible: userLocationSwitch,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: selectedTabColor,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: IconButton(
                color: Colors.white,
                iconSize: 20,
                icon: Icon(Icons.my_location),
                onPressed: onUserLocation
              ),
            )
          )
        )
      ]
    )
  );
}