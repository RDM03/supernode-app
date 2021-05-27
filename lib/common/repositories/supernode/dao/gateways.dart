import 'package:decimal/decimal.dart';
import 'package:supernodeapp/common/repositories/supernode/clients/supernode_client.dart';
import 'package:supernodeapp/common/utils/url.dart';

import 'dao.dart';
import 'gateways.model.dart';

class GatewaysApi {
  static final String list = '/api/gateways';
  static final String locations = '/api/gateways-loc';
  static final String add = '/api/gateways';
  static final String register = '/api/gateways/register';
  static final String registerReseller = '/api/gateways/register-reseller';
  static final String update = '/api/gateways/{gateway.id}';
  static final String profile = '/api/gateway-profiles';
  static final String frames = '/api/gateways/{gateway.id}/stats';
  static final String getProfile = '/api/gateways/{gateway.id}';
  static final String delete = '/api/gateways/{gateway.id}';
  static final String minerHealth = "/api/wallet/mining_health";
  static final String topUpMiningFuel = "/api/wallet/top-up-mining-fuel";
  static final String withdrawMiningFuel = "/api/wallet/withdraw-mining-fuel";
}

class GatewaysDao extends SupernodeDao {
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

  GatewaysDao(SupernodeHttpClient client) : super(client);

  //remote
  Future<dynamic> list(Map data) {
    return get(url: GatewaysApi.list, data: data);
  }

  Future<dynamic> locations() {
    return get(
      url: GatewaysApi.locations,
    );
  }

  Future<dynamic> add(Map data) {
    return post(url: GatewaysApi.add, data: data).then((res) => res);
  }

  Future<dynamic> register(Map data) {
    return post(url: GatewaysApi.register, data: data).then((res) => res);
  }

  Future<dynamic> registerReseller(Map data) {
    return post(url: GatewaysApi.registerReseller, data: data)
        .then((res) => res);
  }

  Future<dynamic> profile(Map data) {
    return get(url: GatewaysApi.profile, data: data).then((res) => res);
  }

  Future<dynamic> update(String id, Map data) {
    return put(url: Api.url(GatewaysApi.update, id), data: data)
        .then((res) => res);
  }

  Future<dynamic> frames(String id, Map data) {
    return get(url: Api.url(GatewaysApi.frames, id), data: data);
  }

  Future<dynamic> deleteGateway(String id) {
    return delete(url: Api.url(GatewaysApi.delete, id)).then((res) => res);
  }

  Future<void> topUpMiningFuel({
    String currency,
    String orgId,
    List<GatewayAmountRequest> topUps,
  }) {
    return post(url: GatewaysApi.topUpMiningFuel, data: {
      'currency': currency,
      'orgId': orgId,
      'topUps': [
        for (final t in topUps)
          {
            'amount': t.amount,
            'gatewayMac': t.gatewayMac,
          }
      ]
    });
  }

  Future<void> withdrawMiningFuel({
    String currency,
    String orgId,
    List<GatewayAmountRequest> withdraws,
  }) {
    return post(url: GatewaysApi.withdrawMiningFuel, data: {
      'currency': currency,
      'orgId': orgId,
      'withdrawals': [
        for (final t in withdraws)
          {
            'amount': t.amount,
            'gatewayMac': t.gatewayMac,
          }
      ]
    });
  }

  Future<List<MinerHealthResponse>> minerHealth(Map data) {
    return get(url: GatewaysApi.minerHealth, data: data).then((res) {
      final List<MinerHealthResponse> minersHealth = [];
      if (res != null && res.containsKey('miningHealthAverage'))
        minersHealth.add(
          MinerHealthResponse(
            id: 'health_score',
            health: res['miningHealthAverage']['overall']?.toDouble(),
            miningFuelHealth:
                res['miningHealthAverage']['miningFuelHealth']?.toDouble(),
            uptimeHealth:
                res['miningHealthAverage']['uptimeHealth']?.toDouble(),
          ),
        );
      if (res != null && res.containsKey('gatewayHealth'))
        res['gatewayHealth']
            .forEach((e) => minersHealth.add(MinerHealthResponse.fromMap(e)));
      return minersHealth;
    });
  }
}
