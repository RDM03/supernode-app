import 'package:supernodeapp/common/daos/app_dao.dart';
import 'package:supernodeapp/common/daos/demo/demo_dao.dart';

class DemoStakeDao extends DemoDao implements StakeDao {
  @override
  Future activestakes(Map data) {
    return Future.value(Mock.activestakes);
  }

  @override
  Future amount(String orgId) {
    return Future.value(Mock.activestakes);
  }

  @override
  Future history(Map data) {
    return Future.value(Mock.stakeHistory);
  }

  @override
  Future stake(Map data) {
    throw UnimplementedError('stake not supported in demo');
  }

  @override
  Future unstake(Map data) {
    throw UnimplementedError('unstake not supported in demo');
  }
}
