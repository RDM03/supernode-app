import 'package:flutter/foundation.dart';
import 'package:supernodeapp/common/repositories/supernode/clients/supernode_client.dart';
import 'dao.dart';

import 'dhx.model.dart';
export 'dhx.model.dart';

class DhxApi {
  static final String listCouncils = '/api/dhx-mining/list-councils';
  static final String listStakes = '/api/dhx-mining/list-stakes';
  static final String createCouncil = '/api/dhx-mining/create-council';
  static final String createStake = '/api/dhx-mining/create-stake';
  static final String lastMining = '/api/dhx-mining/last-mining';
  static final String bondInfo = '/api/dhx-mining/bond-info';
}

class DhxDao extends SupernodeDao {
  DhxDao(SupernodeHttpClient client) : super(client);

  Future<List<Council>> listCouncils() async {
    final res = await get(url: DhxApi.listCouncils);
    final list = res['council'] as List;
    return list
        .map((l) => Council.fromMap(Map<String, dynamic>.from(l)))
        .toList();
  }

  Future<List<StakeDHX>> listStakes({
    String chairOrgId = '0',
    String organizationId = '0',
  }) async {
    final res = await get(url: DhxApi.listStakes, data: {
      'chairOrgId': chairOrgId,
      'organizationId': organizationId,
    });
    final list = res['stake'] as List;
    return list
        .map((l) => StakeDHX.fromMap(Map<String, dynamic>.from(l)))
        .toList();
  }

  Future<dynamic> bondInfo({String organizationId = '0'}) {
    return post(url: DhxApi.bondInfo, data: {'orgId': organizationId});
  }

  Future<CreateCouncilResponse> createCouncil({
    @required String amount,
    @required String boost,
    @required String lockMonths,
    @required String name,
    @required String organizationId,
  }) async {
    final res = await post(url: DhxApi.createCouncil, data: {
      'amount': amount,
      'boost': boost,
      'currency': 'ETH_MXC',
      'lockMonths': lockMonths,
      'name': name,
      'organizationId': organizationId,
    });
    return CreateCouncilResponse.fromMap(res);
  }

  Future<String> createStake({
    @required String amount,
    @required String boost,
    @required String councilId,
    @required String lockMonths,
    @required String organizationId,
  }) async {
    final res = await post(url: DhxApi.createStake, data: {
      'amount': amount,
      'boost': boost,
      'currency': 'ETH_MXC',
      'councilId': councilId,
      'lockMonths': lockMonths,
      'organizationId': organizationId,
    });
    return res == null ? null : res['stakeId'];
  }

  Future<LastMiningResponse> lastMining() async {
    var res = await get(url: DhxApi.lastMining);
    return LastMiningResponse.fromMap(Map<String, dynamic>.from(res));
  }
}
