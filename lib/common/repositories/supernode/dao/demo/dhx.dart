import 'package:flutter/foundation.dart';
import 'package:supernodeapp/common/utils/currencies.dart';

import 'demo.dart';
import '../dhx.dart';

class DemoDhxDao extends DemoDao implements DhxDao {
  Future<List<Council>> listCouncils() async {
    return [
      Council(
          chairOrgId: '123',
          name: 'Council',
          id: 'demo1',
          lastMpower: '1000000'),
      Council(
          chairOrgId: '123',
          name: 'Council 2',
          id: 'demo1',
          lastMpower: '1500000'),
    ];
  }

  Future<CreateCouncilResponse> createCouncil({
    @required String amount,
    @required String boost,
    @required String lockMonths,
    @required String name,
    @required String organizationId,
  }) async {
    return CreateCouncilResponse('demo-council', 'demo-stake');
  }

  Future<String> createStake({
    @required String amount,
    @required String boost,
    @required String councilId,
    @required String lockMonths,
    @required String organizationId,
  }) async {
    return 'demo-stake';
  }

  @override
  Future<LastMiningResponse> lastMining() async {
    return LastMiningResponse(DateTime.now(), '100000', '90000');
  }

  @override
  Future<List<StakeDHX>> listStakes({
    String chairOrgId = '0',
    String organizationId = '0',
  }) async {
    return [
      StakeDHX(
        amount: "123123",
        boost: "0.40",
        closed: false,
        councilId: "demo1",
        councilName: "Council 1",
        created: DateTime(2020, 12, 18, 15, 5),
        lockTill: DateTime(2021, 12, 18, 15, 5),
        currency: Token.mxc,
        dhxMined: "11111",
        lockMonths: "12",
        id: "demoStake",
        organizationId: "testOrgId",
      )
    ];
  }

  @override
  Future<void> bondInfo({String organizationId = '0'}) {
    throw UnimplementedError();
  }

  @override
  Future<dynamic> bondDhx(String amount, String organizationId) {
    throw UnimplementedError();
  }

  @override
  Future<dynamic> unbondDhx(String amount, String organizationId) {
    throw UnimplementedError();
  }
}
