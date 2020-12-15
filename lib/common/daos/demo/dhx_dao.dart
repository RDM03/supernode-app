import 'package:flutter/foundation.dart';
import 'package:supernodeapp/common/daos/demo/demo_dao.dart';
import 'package:supernodeapp/common/daos/dhx_dao.dart';

class DemoDhxDao extends DemoDao implements DhxDao {
  Future<List<Council>> listCouncils() async {
    return [
      Council(chairOrgId: '123', name: 'Council', id: 'demo1'),
      Council(chairOrgId: '123', name: 'Council 2', id: 'demo1'),
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
}
