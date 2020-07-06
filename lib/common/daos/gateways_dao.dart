

import 'api.dart';
import 'dao.dart';

class GatewaysApi {
  static final String list = '/api/gateways';
  static final String locations = '/api/gateways-loc';
  static final String add = '/api/gateways';
  static final String register = '/api/gateways/register';
  static final String update = '/api/gateways/{gateway.id}';
  static final String profile = '/api/gateway-profiles';
}

class GatewaysDao extends Dao{
  static final String id = 'id';
  static final String name = 'name';
  static final String description = 'description';
  static final String location = 'location';
  static final String organizationID = 'organizationID';
  static final String discoveryEnabled = 'discoveryEnabled';
  static final String networkServerID = 'networkServerID';
  static final String gatewayProfileID = 'gatewayProfileID';
  static final String boards = 'boards';
  static final String createdAt = 'createdAt';
  static final String updatedAt = 'updatedAt';
  static final String firstSeenAt = 'firstSeenAt';
  static final String lastSeenAt = 'lastSeenAt';

  //remote
  Future<dynamic> list(Map data){
    return get(
      url: GatewaysApi.list,
      data: data
    );
  }

  Future<dynamic> locations(){
    return get(
      url: GatewaysApi.locations,
    );
  }

  Future<dynamic> add(Map data){
    return post(
      url: GatewaysApi.add,
      data: data
    ).then((res) => res);
  }

  Future<dynamic> register(Map data){
    return post(
      url: GatewaysApi.register,
      data: data
    ).then((res) => res);
  }

  Future<dynamic> profile(Map data){
    return get(
      url: GatewaysApi.profile,
      data: data
    ).then((res) => res);
  }

  Future<dynamic> update(String id,Map data){
    return put(
      url: Api.url(GatewaysApi.update, id),
      data: data
    ).then((res) => res);
  }
}