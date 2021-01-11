import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:supernodeapp/common/components/map_box.dart';
import 'package:supernodeapp/common/daos/gateways_dao.dart';
import 'package:supernodeapp/common/utils/log.dart';
import 'package:supernodeapp/common/utils/tools.dart';
import 'package:supernodeapp/configs/images.dart';
import 'package:supernodeapp/configs/sys.dart';

class GatewaysLocationDao {
  // singleton
  factory GatewaysLocationDao() => _getInstance();

  static GatewaysLocationDao get instance => _getInstance();
  static GatewaysLocationDao _instance;

  GatewaysLocationDao._internal();

  static GatewaysLocationDao _getInstance() {
    if (_instance == null) {
      _instance = new GatewaysLocationDao._internal();
    }
    return _instance;
  }

  Future<String> loadListJson() async {
    return await rootBundle.loadString(Sys.gateways_location_list);
  }

  Future<List> listFromLocal() async {
    String listStr = await this.loadListJson();
    List<dynamic> listJson = json.decode(listStr);

    return geojsonList(listJson);
  }

  List geojsonList(listJson) {
    List features = [];
    Map feature;
    var location;

    for (int index = 0; index < listJson.length; index++) {
      location = listJson[index]['location'];

      LatLng latlng = Tools.convertLatLng(location);
      feature = {
        "type": "Feature",
        "properties": {},
        "geometry": {
          "type": "Point",
          "coordinates": [latlng.longitude, latlng.latitude]
        }
      };

      features.add(feature);
    }

    return features;
  }

  Future<List<MapMarker>> list() async {
    GatewaysDao dao = GatewaysDao();
    List<MapMarker> locations = [];

    var res = await dao.locations();
    mLog('GatewaysDao locations', res);

    if (res['result'].length > 0) {
      for (int index = 0; index < res['result'].length; index++) {
        var location = res['result'][index]['location'];
        var marker = MapMarker(
          point: Tools.convertLatLng(location),
          image: AppImages.gateways,
        );
        locations.add(marker);
      }
    }

    return locations;
  }
}
