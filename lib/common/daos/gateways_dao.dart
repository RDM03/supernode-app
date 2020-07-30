import 'dart:convert';
import 'dart:developer';

import 'api.dart';
import 'dao.dart';

class GatewaysApi {
  static final String list = '/api/gateways';
  static final String locations = '/api/gateways-loc';
  static final String add = '/api/gateways';
  static final String register = '/api/gateways/register';
  static final String update = '/api/gateways/{gateway.id}';
  static final String profile = '/api/gateway-profiles';
  static final String frames = '/api/gateways/{gateway.id}/stats'; 
  static final String getProfile = '/api/gateways/{gateway.id}'; 
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
  static final String model = 'model';
  static final String osversion = 'osversion';

  //remote
  Future<dynamic> list(Map data) async {
    final res =  await get(
      url: GatewaysApi.list,
      data: data
    );
    final s = json.encode(res);
    debugger(); 
    return res;
  }

  Future<dynamic> locations() async {
    final res =  await get(
      url: GatewaysApi.locations,
    );
    final s = json.encode(res);
    debugger(); 
    return res;
  }

  Future<dynamic> add(Map data) async {
    final res = await  post(
      url: GatewaysApi.add,
      data: data
    ).then((res) => res);
    final s = json.encode(res);
    debugger(); 
    return res;
  }

  Future<dynamic> register(Map data) async {
    final res = await post(
      url: GatewaysApi.register,
      data: data
    ).then((res) => res);
    final s = json.encode(res);
    debugger(); 
    return res;
  }

  Future<dynamic> profile(Map data) async {
    final res = await get(
      url: GatewaysApi.profile,
      data: data
    ).then((res) => res);
    final s = json.encode(res);
    debugger(); 
    return res;
  }

  Future<dynamic> update(String id,Map data) async {
    final res =  await put(
      url: Api.url(GatewaysApi.update, id),
      data: data
    ).then((res) => res);
    final s = json.encode(res);
    debugger(); 
    return res;
  }

  Future<dynamic> frames(String id,Map data) async {
    final res =  await get(
      url: Api.url(GatewaysApi.frames,id),
      data: data
    );
    final s = json.encode(res);
    debugger(); 
    return res;
  }
}