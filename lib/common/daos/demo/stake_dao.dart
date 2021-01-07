import 'package:supernodeapp/common/daos/app_dao.dart';
import 'package:supernodeapp/common/daos/demo/demo_dao.dart';
import 'package:supernodeapp/common/daos/demo/user_dao.dart';

class DemoStakeDao extends DemoDao implements StakeDao {
  @override
  Future activestakes(Map data) {
    return Future.value({
      "actStake": [
        {
          "id": "81",
          "startTime": "2020-09-08T14:01:20Z",
          "endTime": null,
          "amount": "200",
          "active": true,
          "lockTill": "2021-03-07T14:01:20Z",
          "boost": "0.05",
          "revenue": "0"
        },
        {
          "id": "82",
          "startTime": "2020-09-08T14:04:36Z",
          "endTime": null,
          "amount": "20",
          "active": true,
          "lockTill": "2021-06-05T14:04:36Z",
          "boost": "0.15",
          "revenue": "0"
        },
        {
          "id": "83",
          "startTime": "2020-09-10T12:10:05Z",
          "endTime": null,
          "amount": "1766.23",
          "active": true,
          "lockTill": "2021-03-09T12:10:05Z",
          "boost": "0.05",
          "revenue": "0"
        },
        {
          "id": "86",
          "startTime": "2020-09-10T13:59:34Z",
          "endTime": null,
          "amount": "1046.98",
          "active": true,
          "lockTill": null,
          "boost": "",
          "revenue": "0"
        },
        {
          "id": "87",
          "startTime": "2020-09-10T15:27:17Z",
          "endTime": null,
          "amount": "1",
          "active": true,
          "lockTill": null,
          "boost": "",
          "revenue": "0"
        },
        {
          "id": "88",
          "startTime": "2020-09-10T16:12:29Z",
          "endTime": null,
          "amount": "1657.45",
          "active": true,
          "lockTill": "2022-08-31T16:12:29Z",
          "boost": "0.4",
          "revenue": "0"
        },
        {
          "id": "89",
          "startTime": "2020-09-11T14:21:18Z",
          "endTime": null,
          "amount": "3988.1",
          "active": true,
          "lockTill": "2021-06-08T14:21:18Z",
          "boost": "0.15",
          "revenue": "0"
        }
      ]
    });
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

  @override
  Future<dynamic> dhxStakesList(Map data) {
    throw UnimplementedError('DHX token is not supported in demo');
  }
}
