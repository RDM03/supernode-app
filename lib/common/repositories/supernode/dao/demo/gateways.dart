import 'package:decimal/decimal.dart';

import '../gateways.model.dart';
import 'demo.dart';
import '../gateways.dart';

class DemoGatewaysDao extends DemoDao implements GatewaysDao {
  @override
  Future list(Map data, {String search}) {
    final offset = data['offset'] ?? 0;
    final limit = data['limit'] ?? 10000;
    return Future.value({
      'totalCount': '30',
      'result': [
        {
          'id': '1',
          'discoveryEnabled': false,
          'gatewayProfileId': '123',
          'name': 'gateways',
          'description': 'string',
          'createdAt': '2020-04-15T13:01:41.617Z',
          'updatedAt': '2020-04-15T13:01:41.617Z',
          'firstSeenAt': '2020-04-15T13:01:41.617Z',
          'lastSeenAt': '2020-04-15T13:01:41.617Z',
          'organizationID': 'organizationID',
          'networkServerID': 'networkServerID',
          'model': 'MX1901',
          'osversion': '0.1.1',
          'location': {
            'latitude': 52.512270,
            'longitude': 13.417280,
            'altitude': 0.0,
            'source': 'UNKNOWN',
            'accuracy': 0.0,
          }
        },
        {
          'id': '2',
          'discoveryEnabled': false,
          'gatewayProfileId': '123',
          'name': 'gateways2',
          'description': 'string',
          'createdAt': '2020-04-15T13:01:41.617Z',
          'updatedAt': '2020-04-15T13:01:41.617Z',
          'firstSeenAt': '2020-04-15T13:01:41.617Z',
          'lastSeenAt': '2020-04-15T13:01:41.617Z',
          'organizationID': 'organizationID',
          'networkServerID': 'networkServerID',
          'model': 'MX1901',
          'osversion': '0.1.1',
          'location': {
            'latitude': 52.512270,
            'longitude': 13.417280,
            'altitude': 0.0,
            'source': 'UNKNOWN',
            'accuracy': 200,
          }
        },
        for (var i = 3; i <= 30; i++)
          {
            'id': i.toString(),
            'discoveryEnabled': false,
            'gatewayProfileId': '123',
            'name': 'gateways$i',
            'description': 'string',
            'createdAt': '2020-04-15T13:01:41.617Z',
            'updatedAt': '2020-04-15T13:01:41.617Z',
            'firstSeenAt': '2020-04-15T13:01:41.617Z',
            'lastSeenAt': '2020-04-15T13:01:41.617Z',
            'organizationID': 'organizationID',
            '': 'networkServerID',
            'model': 'MX1901',
            'osversion': '0.1.1',
            'location': {
              'latitude': 52.512270,
              'longitude': 13.417280,
              'altitude': 0.0,
              'source': 'UNKNOWN',
              'accuracy': 200,
            }
          },
      ].skip(offset).take(limit).toList()
    });
  }

  @override
  Future locations() {
    return Future.value({
      'result': [
        {
          'location': {
            'latitude': 52.512270,
            'longitude': 13.417280,
            'altitude': 0.0,
          }
        }
      ]
    });
  }

  @override
  Future profile(Map data) {
    return Future.value({
      'totalCount': 'string',
      'result': [
        {
          'id': 'string',
          'name': 'string',
          'networkServerID': 'string',
          'networkServerName': 'string',
          'createdAt': '2020-07-09T16:12:32.445Z',
          'updatedAt': '2020-07-09T16:12:32.445Z'
        }
      ]
    });
  }

  @override
  Future<List<GatewayStatisticResponse>> frames(
    String id, {
    String interval,
    DateTime startTimestamp,
    DateTime endTimestamp,
  }) {
    return Future.value([
      {
        "timestamp": DateTime.now()
            .add(Duration(
              days: -2,
            ))
            .toUtc()
            .toIso8601String(),
        "rxPacketsReceived": 10,
        "rxPacketsReceivedOK": 15,
        "txPacketsReceived": 15,
        "txPacketsEmitted": 15
      },
      {
        "timestamp": DateTime.now()
            .add(Duration(
              days: -1,
            ))
            .toUtc()
            .toIso8601String(), //"2020-07-09T19:03:56.869Z",
        "rxPacketsReceived": 7,
        "rxPacketsReceivedOK": 5,
        "txPacketsReceived": 6,
        "txPacketsEmitted": 3
      },
    ].map((e) => GatewayStatisticResponse.fromMap(e)).toList());
  }

  @override
  Future add(Map data) {
    throw UnimplementedError('add not supported in demo');
  }

  @override
  Future register(Map data) {
    throw UnimplementedError('register not supported in demo');
  }

  @override
  Future registerReseller(Map data) {
    throw UnimplementedError('register not supported in demo');
  }

  @override
  Future update(String id, Map data) {
    throw UnimplementedError('update not supported in demo');
  }

  @override
  Future deleteGateway(String id) {
    throw UnimplementedError('delete not supported in demo');
  }

  @override
  Future<List<MinerHealthResponse>> minerHealth(Map data) {
    return Future.value([
      MinerHealthResponse(
        ageSeconds: 10000,
        health: 0.71,
        miningFuel: Decimal.fromInt(2500),
        miningFuelHealth: 0.5,
        miningFuelMax: Decimal.fromInt(5000),
      )
    ]);
  }
}
