import 'package:supernodeapp/common/daos/app_dao.dart';
import 'package:supernodeapp/common/daos/demo/demo_dao.dart';

class DemoGatewaysDao extends DemoDao implements GatewaysDao {
  @override
  Future list(Map data) {
    return Future.value({
      'totalCount': '2',
      'result': [
        {
          'id': '1',
          'name': 'gateways',
          'description': 'string',
          'createdAt': '2020-04-15T13:01:41.617Z',
          'updatedAt': '2020-04-15T13:01:41.617Z',
          'firstSeenAt': '2020-04-15T13:01:41.617Z',
          'lastSeenAt': '2020-04-15T13:01:41.617Z',
          'organizationID': 'organizationID',
          'networkServerID': 'networkServerID',
          'location': {
            'latitude': 0,
            'longitude': 0,
            'altitude': 0,
            'source': 'UNKNOWN',
            'accuracy': 0,
          }
        },
        {
          'id': '2',
          'name': 'gateways2',
          'description': 'string',
          'createdAt': '2020-04-15T13:01:41.617Z',
          'updatedAt': '2020-04-15T13:01:41.617Z',
          'firstSeenAt': '2020-04-15T13:01:41.617Z',
          'lastSeenAt': '2020-04-15T13:01:41.617Z',
          'organizationID': 'organizationID',
          'networkServerID': 'networkServerID',
          'location': {
            'latitude': 0,
            'longitude': 0,
            'altitude': 0,
            'source': 'UNKNOWN',
            'accuracy': 200,
          }
        }
      ]
    });
  }

  @override
  Future locations() {
    return Future.value({
      'result': [
        {
          'location': {
            'latitude': 0,
            'longitude': 0,
            'altitude': 0,
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
  Future add(Map data) {
    throw UnimplementedError('add not supported in demo');
  }

  @override
  Future register(Map data) {
    throw UnimplementedError('register not supported in demo');
  }

  @override
  Future update(String id, Map data) {
    throw UnimplementedError('update not supported in demo');
  }
}
