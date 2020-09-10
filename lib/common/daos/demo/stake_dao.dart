import 'package:supernodeapp/common/daos/app_dao.dart';
import 'package:supernodeapp/common/daos/demo/demo_dao.dart';
import 'package:supernodeapp/common/daos/demo/user_dao.dart';

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
  Future stake(Map data) async {
    return Future.value({
      "status": "Demo mode",
      ...(await DemoUserDao().profile() as Map),
    });
  }

  @override
  Future unstake(Map data) async {
    return Future.value({
      "status": "Demo mode",
      ...(await DemoUserDao().profile() as Map),
    });
  }

  @override
  Future revenue(Map data) {
    return Future.value({'amount': 120});
  }

  @override
  Future stakingPercentage() {
    return Future.value({
      "stakingInterest": 0.005,
      "lockBoosts": [
        {"lockPeriods": "6", "boost": "0.05"},
        {"lockPeriods": "9", "boost": "0.15"},
        {"lockPeriods": "12", "boost": "0.25"},
        {"lockPeriods": "24", "boost": "0.4"}
      ]
    });
  }
}
