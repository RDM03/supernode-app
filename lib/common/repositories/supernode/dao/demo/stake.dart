import 'package:flutter/material.dart';
import 'package:supernodeapp/common/repositories/supernode/dao/demo/user.dart';

import 'demo.dart';
import '../stake.dart';

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
  Future<List<StakeHistoryEntity>> history({
    @required String orgId,
    String currency,
    DateTime from,
    DateTime till,
  }) {
    return Future.value({
      "stakingHist": [
        {
          "timestamp": "2020-04-24T20:15:27Z",
          "amount": "-10",
          "type": "STAKING",
          "stake": {
            "active": false,
            "amount": "10",
            "boost": "5",
            "lockTill": "2020-04-26T20:15:35Z",
            "endTime": "2020-04-24T20:15:35Z",
            "id": "45",
            "startTime": "2020-04-24T20:15:27Z",
          }
        },
        {
          "timestamp": "2020-04-24T20:15:35Z",
          "amount": "10",
          "type": "UNSTAKING",
          "stake": {
            "id": "45",
            "startTime": "2020-04-24T20:15:27Z",
            "endTime": "2020-04-24T20:15:35Z",
            "amount": "10",
            "active": false,
            "boost": "5",
            "lockTill": "2020-04-26T20:15:35Z",
          }
        },
        {
          "timestamp": "2020-04-24T20:18:05Z",
          "amount": "-100",
          "type": "STAKING",
          "stake": {
            "id": "46",
            "startTime": "2020-04-24T20:18:05Z",
            "endTime": "2020-04-30T14:58:48Z",
            "amount": "100",
            "active": false,
            "boost": "5",
            "lockTill": "2020-04-26T20:15:35Z",
          }
        },
        {
          "timestamp": "2020-04-30T14:58:48Z",
          "amount": "100",
          "type": "UNSTAKING",
          "stake": {
            "id": "46",
            "startTime": "2020-04-24T20:18:05Z",
            "endTime": "2020-04-30T14:58:48Z",
            "amount": "100",
            "active": false,
            "boost": "5",
            "lockTill": "2020-04-26T20:15:35Z",
          }
        },
        {
          "timestamp": "2020-05-08T13:21:51Z",
          "amount": "-10",
          "type": "STAKING",
          "stake": {
            "id": "47",
            "startTime": "2020-05-08T13:21:51Z",
            "endTime": "2020-05-08T13:24:23Z",
            "amount": "10",
            "active": false,
            "boost": "5",
            "lockTill": "2020-04-26T20:15:35Z",
          }
        },
        {
          "timestamp": "2020-05-08T13:24:23Z",
          "amount": "10",
          "type": "UNSTAKING",
          "stake": {
            "id": "47",
            "startTime": "2020-05-08T13:21:51Z",
            "endTime": "2020-05-08T13:24:23Z",
            "amount": "10",
            "active": false,
            "boost": "3",
            "lockTill": "2020-04-26T20:15:35Z",
          }
        },
        {
          "timestamp": "2020-05-18T15:53:38Z",
          "amount": "-20",
          "type": "STAKING",
          "stake": {
            "id": "48",
            "startTime": "2020-05-18T15:53:38Z",
            "endTime": "2020-06-03T07:32:18Z",
            "amount": "20",
            "active": false,
            "boost": "5",
            "lockTill": "2020-04-26T20:15:35Z",
          }
        },
        {
          "timestamp": "2020-06-03T07:32:18Z",
          "amount": "20",
          "type": "UNSTAKING",
          "stake": {
            "id": "48",
            "startTime": "2020-05-18T15:53:38Z",
            "endTime": "2020-06-03T07:32:18Z",
            "amount": "20",
            "active": false
          }
        },
        {
          "timestamp": "2020-06-03T07:43:12Z",
          "amount": "-600",
          "type": "STAKING",
          "stake": {
            "id": "49",
            "startTime": "2020-06-03T07:43:12Z",
            "endTime": "2020-06-04T13:55:33Z",
            "amount": "600",
            "active": false
          }
        },
        {
          "timestamp": "2020-06-04T11:31:55Z",
          "amount": "0.06",
          "type": "STAKING_REWARD",
          "stake": {
            "id": "48",
            "startTime": "2020-05-18T15:53:38Z",
            "endTime": "2020-06-03T07:32:18Z",
            "amount": "20",
            "active": false
          }
        },
        {
          "timestamp": "2020-06-04T13:55:33Z",
          "amount": "600",
          "type": "UNSTAKING",
          "stake": {
            "id": "49",
            "startTime": "2020-06-03T07:43:12Z",
            "endTime": "2020-06-04T13:55:33Z",
            "amount": "600",
            "active": false
          }
        },
        {
          "timestamp": "2020-06-04T14:26:14Z",
          "amount": "-200",
          "type": "STAKING",
          "stake": {
            "id": "50",
            "startTime": "2020-06-04T14:26:14Z",
            "endTime": "2020-06-05T07:51:43Z",
            "amount": "200",
            "active": false
          }
        },
        {
          "timestamp": "2020-06-05T07:51:43Z",
          "amount": "200",
          "type": "UNSTAKING",
          "stake": {
            "id": "50",
            "startTime": "2020-06-04T14:26:14Z",
            "endTime": "2020-06-05T07:51:43Z",
            "amount": "200",
            "active": false
          }
        },
        {
          "timestamp": "2020-06-05T07:51:55Z",
          "amount": "-10",
          "type": "STAKING",
          "stake": {
            "id": "51",
            "startTime": "2020-06-05T07:51:55Z",
            "endTime": "2020-06-05T09:19:59Z",
            "amount": "10",
            "active": false
          }
        },
        {
          "timestamp": "2020-06-05T09:19:59Z",
          "amount": "10",
          "type": "UNSTAKING",
          "stake": {
            "id": "51",
            "startTime": "2020-06-05T07:51:55Z",
            "endTime": "2020-06-05T09:19:59Z",
            "amount": "10",
            "active": false
          }
        },
        {
          "timestamp": "2020-06-05T09:20:33Z",
          "amount": "-30",
          "type": "STAKING",
          "stake": {
            "id": "52",
            "startTime": "2020-06-05T09:20:33Z",
            "endTime": "2020-06-05T14:46:49Z",
            "amount": "30",
            "active": false
          }
        },
        {
          "timestamp": "2020-06-05T14:46:49Z",
          "amount": "30",
          "type": "UNSTAKING",
          "stake": {
            "id": "52",
            "startTime": "2020-06-05T09:20:33Z",
            "endTime": "2020-06-05T14:46:49Z",
            "amount": "30",
            "active": false
          }
        },
        {
          "timestamp": "2020-06-05T14:52:28Z",
          "amount": "-30",
          "type": "STAKING",
          "stake": {
            "id": "53",
            "startTime": "2020-06-05T14:52:28Z",
            "endTime": "2020-06-10T16:18:09Z",
            "amount": "30",
            "active": false
          }
        },
        {
          "timestamp": "2020-06-10T16:18:09Z",
          "amount": "30",
          "type": "UNSTAKING",
          "stake": {
            "id": "53",
            "startTime": "2020-06-05T14:52:28Z",
            "endTime": "2020-06-10T16:18:09Z",
            "amount": "30",
            "active": false
          }
        },
        {
          "timestamp": "2020-06-10T16:18:18Z",
          "amount": "-30",
          "type": "STAKING",
          "stake": {
            "id": "54",
            "startTime": "2020-06-10T16:18:18Z",
            "endTime": "2020-06-30T16:00:20Z",
            "amount": "30",
            "active": false
          }
        },
        {
          "timestamp": "2020-06-21T15:00:00Z",
          "amount": "0.09",
          "type": "STAKING_REWARD",
          "stake": {
            "id": "54",
            "startTime": "2020-06-10T16:18:18Z",
            "endTime": "2020-06-30T16:00:20Z",
            "amount": "30",
            "active": false
          }
        },
        {
          "timestamp": "2020-06-30T16:00:20Z",
          "amount": "30",
          "type": "UNSTAKING",
          "stake": {
            "id": "54",
            "startTime": "2020-06-10T16:18:18Z",
            "endTime": "2020-06-30T16:00:20Z",
            "amount": "30",
            "active": false
          }
        },
        {
          "timestamp": "2020-06-30T16:00:32Z",
          "amount": "-50",
          "type": "STAKING",
          "stake": {
            "id": "55",
            "startTime": "2020-06-30T16:00:32Z",
            "endTime": "2020-07-08T14:38:56Z",
            "amount": "50",
            "active": false
          }
        },
        {
          "timestamp": "2020-07-08T14:38:56Z",
          "amount": "50",
          "type": "UNSTAKING",
          "stake": {
            "id": "55",
            "startTime": "2020-06-30T16:00:32Z",
            "endTime": "2020-07-08T14:38:56Z",
            "amount": "50",
            "active": false
          }
        },
        {
          "timestamp": "2020-07-08T14:39:09Z",
          "amount": "-3",
          "type": "STAKING",
          "stake": {
            "id": "56",
            "startTime": "2020-07-08T14:39:09Z",
            "endTime": "2020-07-08T17:59:46Z",
            "amount": "3",
            "active": false
          }
        },
        {
          "timestamp": "2020-07-08T17:59:46Z",
          "amount": "3",
          "type": "UNSTAKING",
          "stake": {
            "id": "56",
            "startTime": "2020-07-08T14:39:09Z",
            "endTime": "2020-07-08T17:59:46Z",
            "amount": "3",
            "active": false
          }
        },
        {
          "timestamp": "2020-07-08T18:00:27Z",
          "amount": "-10",
          "type": "STAKING",
          "stake": {
            "id": "57",
            "startTime": "2020-07-08T18:00:27Z",
            "endTime": "2020-07-08T19:02:24Z",
            "amount": "10",
            "active": false
          }
        },
        {
          "timestamp": "2020-07-08T19:02:24Z",
          "amount": "10",
          "type": "UNSTAKING",
          "stake": {
            "id": "57",
            "startTime": "2020-07-08T18:00:27Z",
            "endTime": "2020-07-08T19:02:24Z",
            "amount": "10",
            "active": false
          }
        },
        {
          "timestamp": "2020-07-08T19:02:58Z",
          "amount": "-1",
          "type": "STAKING",
          "stake": {
            "id": "58",
            "startTime": "2020-07-08T19:02:58Z",
            "endTime": "2020-07-08T19:04:19Z",
            "amount": "1",
            "active": false
          }
        },
        {
          "timestamp": "2020-07-08T19:04:19Z",
          "amount": "1",
          "type": "UNSTAKING",
          "stake": {
            "id": "58",
            "startTime": "2020-07-08T19:02:58Z",
            "endTime": "2020-07-08T19:04:19Z",
            "amount": "1",
            "active": false
          }
        },
        {
          "timestamp": "2020-07-13T09:22:21Z",
          "amount": "-100",
          "type": "STAKING",
          "stake": {
            "id": "59",
            "startTime": "2020-07-13T09:22:21Z",
            "endTime": "2020-07-13T09:23:09Z",
            "amount": "100",
            "active": false
          }
        },
        {
          "timestamp": "2020-07-13T09:23:09Z",
          "amount": "100",
          "type": "UNSTAKING",
          "stake": {
            "id": "59",
            "startTime": "2020-07-13T09:22:21Z",
            "endTime": "2020-07-13T09:23:09Z",
            "amount": "100",
            "active": false
          }
        },
        {
          "timestamp": "2020-07-13T09:27:28Z",
          "amount": "-100",
          "type": "STAKING",
          "stake": {
            "id": "60",
            "startTime": "2020-07-13T09:27:28Z",
            "endTime": "2020-07-13T13:07:34Z",
            "amount": "100",
            "active": false
          }
        },
        {
          "timestamp": "2020-07-13T13:07:34Z",
          "amount": "100",
          "type": "UNSTAKING",
          "stake": {
            "id": "60",
            "startTime": "2020-07-13T09:27:28Z",
            "endTime": "2020-07-13T13:07:34Z",
            "amount": "100",
            "active": false
          }
        },
        {
          "timestamp": "2020-07-16T11:31:18Z",
          "amount": "-100",
          "type": "STAKING",
          "stake": {
            "id": "61",
            "startTime": "2020-07-16T11:31:18Z",
            "endTime": "2020-07-16T11:33:01Z",
            "amount": "100",
            "active": false
          }
        },
        {
          "timestamp": "2020-07-16T11:33:01Z",
          "amount": "100",
          "type": "UNSTAKING",
          "stake": {
            "id": "61",
            "startTime": "2020-07-16T11:31:18Z",
            "endTime": "2020-07-16T11:33:01Z",
            "amount": "100",
            "active": false
          }
        },
        {
          "timestamp": "2020-07-17T12:20:29Z",
          "amount": "-10",
          "type": "STAKING",
          "stake": {
            "id": "62",
            "startTime": "2020-07-17T12:20:29Z",
            "endTime": "2020-07-20T14:46:59Z",
            "amount": "10",
            "active": false
          }
        },
        {
          "timestamp": "2020-07-20T14:46:59Z",
          "amount": "10",
          "type": "UNSTAKING",
          "stake": {
            "id": "62",
            "startTime": "2020-07-17T12:20:29Z",
            "endTime": "2020-07-20T14:46:59Z",
            "amount": "10",
            "active": false
          }
        },
        {
          "timestamp": "2020-07-20T14:47:09Z",
          "amount": "-100",
          "type": "STAKING",
          "stake": {
            "id": "63",
            "startTime": "2020-07-20T14:47:09Z",
            "endTime": "2020-07-20T15:17:12Z",
            "amount": "100",
            "active": false
          }
        },
        {
          "timestamp": "2020-07-20T15:17:12Z",
          "amount": "100",
          "type": "UNSTAKING",
          "stake": {
            "id": "63",
            "startTime": "2020-07-20T14:47:09Z",
            "endTime": "2020-07-20T15:17:12Z",
            "amount": "100",
            "active": false
          }
        },
        {
          "timestamp": "2020-07-20T15:17:30Z",
          "amount": "-20",
          "type": "STAKING",
          "stake": {
            "id": "64",
            "startTime": "2020-07-20T15:17:30Z",
            "endTime": null,
            "amount": "20",
            "active": false
          }
        },
        {
          "timestamp": "2020-07-28T12:10:37Z",
          "amount": "-100",
          "type": "STAKING",
          "stake": {
            "id": "66",
            "startTime": "2020-07-28T12:10:37Z",
            "endTime": "2020-07-28T12:54:46Z",
            "amount": "100",
            "active": false
          }
        },
        {
          "timestamp": "2020-07-28T12:54:46Z",
          "amount": "100",
          "type": "UNSTAKING",
          "stake": {
            "id": "66",
            "startTime": "2020-07-28T12:10:37Z",
            "endTime": "2020-07-28T12:54:46Z",
            "amount": "100",
            "active": false
          }
        },
        {
          "timestamp": "2020-07-28T13:27:17Z",
          "amount": "4160",
          "type": "STAKING_REWARD",
          "stake": {
            "id": "46",
            "startTime": "2020-04-24T20:18:05Z",
            "endTime": "2020-04-30T14:58:48Z",
            "amount": "100",
            "active": false
          }
        },
        {
          "timestamp": "2020-07-28T13:27:17Z",
          "amount": "0.1",
          "type": "STAKING_REWARD",
          "stake": {
            "id": "47",
            "startTime": "2020-05-08T13:21:51Z",
            "endTime": "2020-05-08T13:24:23Z",
            "amount": "10",
            "active": false
          }
        },
        {
          "timestamp": "2020-07-28T13:27:17Z",
          "amount": "2253.7",
          "type": "STAKING_REWARD",
          "stake": {
            "id": "48",
            "startTime": "2020-05-18T15:53:38Z",
            "endTime": "2020-06-03T07:32:18Z",
            "amount": "20",
            "active": false
          }
        },
        {
          "timestamp": "2020-07-28T13:27:17Z",
          "amount": "5436",
          "type": "STAKING_REWARD",
          "stake": {
            "id": "49",
            "startTime": "2020-06-03T07:43:12Z",
            "endTime": "2020-06-04T13:55:33Z",
            "amount": "600",
            "active": false
          }
        },
        {
          "timestamp": "2020-07-28T13:27:17Z",
          "amount": "1045",
          "type": "STAKING_REWARD",
          "stake": {
            "id": "50",
            "startTime": "2020-06-04T14:26:14Z",
            "endTime": "2020-06-05T07:51:43Z",
            "amount": "200",
            "active": false
          }
        },
        {
          "timestamp": "2020-07-28T13:27:17Z",
          "amount": "4.4",
          "type": "STAKING_REWARD",
          "stake": {
            "id": "51",
            "startTime": "2020-06-05T07:51:55Z",
            "endTime": "2020-06-05T09:19:59Z",
            "amount": "10",
            "active": false
          }
        },
        {
          "timestamp": "2020-07-28T13:27:17Z",
          "amount": "48.9",
          "type": "STAKING_REWARD",
          "stake": {
            "id": "52",
            "startTime": "2020-06-05T09:20:33Z",
            "endTime": "2020-06-05T14:46:49Z",
            "amount": "30",
            "active": false
          }
        },
        {
          "timestamp": "2020-07-28T13:27:17Z",
          "amount": "1092.75",
          "type": "STAKING_REWARD",
          "stake": {
            "id": "53",
            "startTime": "2020-06-05T14:52:28Z",
            "endTime": "2020-06-10T16:18:09Z",
            "amount": "30",
            "active": false
          }
        },
        {
          "timestamp": "2020-07-28T13:27:17Z",
          "amount": "4317.15",
          "type": "STAKING_REWARD",
          "stake": {
            "id": "54",
            "startTime": "2020-06-10T16:18:18Z",
            "endTime": "2020-06-30T16:00:20Z",
            "amount": "30",
            "active": false
          }
        },
        {
          "timestamp": "2020-07-28T13:27:17Z",
          "amount": "2859.5",
          "type": "STAKING_REWARD",
          "stake": {
            "id": "55",
            "startTime": "2020-06-30T16:00:32Z",
            "endTime": "2020-07-08T14:38:56Z",
            "amount": "50",
            "active": false
          }
        },
        {
          "timestamp": "2020-07-28T13:27:17Z",
          "amount": "3",
          "type": "STAKING_REWARD",
          "stake": {
            "id": "56",
            "startTime": "2020-07-08T14:39:09Z",
            "endTime": "2020-07-08T17:59:46Z",
            "amount": "3",
            "active": false
          }
        },
        {
          "timestamp": "2020-07-28T13:27:17Z",
          "amount": "3.05",
          "type": "STAKING_REWARD",
          "stake": {
            "id": "57",
            "startTime": "2020-07-08T18:00:27Z",
            "endTime": "2020-07-08T19:02:24Z",
            "amount": "10",
            "active": false
          }
        },
        {
          "timestamp": "2020-07-28T13:27:17Z",
          "amount": "0.005",
          "type": "STAKING_REWARD",
          "stake": {
            "id": "58",
            "startTime": "2020-07-08T19:02:58Z",
            "endTime": "2020-07-08T19:04:19Z",
            "amount": "1",
            "active": false
          }
        },
        {
          "timestamp": "2020-07-28T13:27:17Z",
          "amount": "110",
          "type": "STAKING_REWARD",
          "stake": {
            "id": "60",
            "startTime": "2020-07-13T09:27:28Z",
            "endTime": "2020-07-13T13:07:34Z",
            "amount": "100",
            "active": false
          }
        },
        {
          "timestamp": "2020-07-28T13:27:17Z",
          "amount": "0.5",
          "type": "STAKING_REWARD",
          "stake": {
            "id": "61",
            "startTime": "2020-07-16T11:31:18Z",
            "endTime": "2020-07-16T11:33:01Z",
            "amount": "100",
            "active": false
          }
        },
        {
          "timestamp": "2020-07-28T13:27:17Z",
          "amount": "223.3",
          "type": "STAKING_REWARD",
          "stake": {
            "id": "62",
            "startTime": "2020-07-17T12:20:29Z",
            "endTime": "2020-07-20T14:46:59Z",
            "amount": "10",
            "active": false
          }
        },
        {
          "timestamp": "2020-07-28T13:27:17Z",
          "amount": "15",
          "type": "STAKING_REWARD",
          "stake": {
            "id": "63",
            "startTime": "2020-07-20T14:47:09Z",
            "endTime": "2020-07-20T15:17:12Z",
            "amount": "100",
            "active": false
          }
        },
        {
          "timestamp": "2020-07-28T13:27:17Z",
          "amount": "22",
          "type": "STAKING_REWARD",
          "stake": {
            "id": "66",
            "startTime": "2020-07-28T12:10:37Z",
            "endTime": "2020-07-28T12:54:46Z",
            "amount": "100",
            "active": false
          }
        },
        {
          "timestamp": "2020-07-28T14:01:29Z",
          "amount": "-100",
          "type": "STAKING",
          "stake": {
            "id": "67",
            "startTime": "2020-07-28T14:01:29Z",
            "endTime": "2020-07-28T14:03:17Z",
            "amount": "100",
            "active": false
          }
        },
        {
          "timestamp": "2020-07-28T14:03:17Z",
          "amount": "100",
          "type": "UNSTAKING",
          "stake": {
            "id": "67",
            "startTime": "2020-07-28T14:01:29Z",
            "endTime": "2020-07-28T14:03:17Z",
            "amount": "100",
            "active": false
          }
        },
        {
          "timestamp": "2020-07-28T14:07:34Z",
          "amount": "-100",
          "type": "STAKING",
          "stake": {
            "id": "68",
            "startTime": "2020-07-28T14:07:34Z",
            "endTime": "2020-07-28T14:12:01Z",
            "amount": "100",
            "active": false
          }
        },
        {
          "timestamp": "2020-07-28T14:07:34Z",
          "amount": "0.5",
          "type": "STAKING_REWARD",
          "stake": {
            "id": "67",
            "startTime": "2020-07-28T14:01:29Z",
            "endTime": "2020-07-28T14:03:17Z",
            "amount": "100",
            "active": false
          }
        },
        {
          "timestamp": "2020-07-28T14:12:01Z",
          "amount": "100",
          "type": "UNSTAKING",
          "stake": {
            "id": "68",
            "startTime": "2020-07-28T14:07:34Z",
            "endTime": "2020-07-28T14:12:01Z",
            "amount": "100",
            "active": false
          }
        },
        {
          "timestamp": "2020-07-28T14:13:40Z",
          "amount": "-100",
          "type": "STAKING",
          "stake": {
            "id": "69",
            "startTime": "2020-07-28T14:13:40Z",
            "endTime": "2020-07-29T08:00:30Z",
            "amount": "100",
            "active": false
          }
        },
        {
          "timestamp": "2020-07-28T14:13:40Z",
          "amount": "2",
          "type": "STAKING_REWARD",
          "stake": {
            "id": "68",
            "startTime": "2020-07-28T14:07:34Z",
            "endTime": "2020-07-28T14:12:01Z",
            "amount": "100",
            "active": false
          }
        },
        {
          "timestamp": "2020-07-28T14:19:58Z",
          "amount": "3",
          "type": "STAKING_REWARD",
          "stake": {
            "id": "69",
            "startTime": "2020-07-28T14:13:40Z",
            "endTime": "2020-07-29T08:00:30Z",
            "amount": "100",
            "active": false
          }
        },
        {
          "timestamp": "2020-07-29T08:00:30Z",
          "amount": "100",
          "type": "UNSTAKING",
          "stake": {
            "id": "69",
            "startTime": "2020-07-28T14:13:40Z",
            "endTime": "2020-07-29T08:00:30Z",
            "amount": "100",
            "active": false
          }
        },
        {
          "timestamp": "2020-07-29T08:05:56Z",
          "amount": "-100",
          "type": "STAKING",
          "stake": {
            "id": "70",
            "startTime": "2020-07-29T08:05:56Z",
            "endTime": "2020-07-29T08:06:49Z",
            "amount": "100",
            "active": false
          }
        },
        {
          "timestamp": "2020-07-29T08:06:49Z",
          "amount": "100",
          "type": "UNSTAKING",
          "stake": {
            "id": "70",
            "startTime": "2020-07-29T08:05:56Z",
            "endTime": "2020-07-29T08:06:49Z",
            "amount": "100",
            "active": false
          }
        },
        {
          "timestamp": "2020-07-29T08:07:07Z",
          "amount": "-400",
          "type": "STAKING",
          "stake": {
            "id": "71",
            "startTime": "2020-07-29T08:07:07Z",
            "endTime": "2020-07-29T11:33:54Z",
            "amount": "400",
            "active": false
          }
        },
        {
          "timestamp": "2020-07-29T11:33:54Z",
          "amount": "400",
          "type": "UNSTAKING",
          "stake": {
            "id": "71",
            "startTime": "2020-07-29T08:07:07Z",
            "endTime": "2020-07-29T11:33:54Z",
            "amount": "400",
            "active": false
          }
        },
        {
          "timestamp": "2020-07-29T11:34:02Z",
          "amount": "-1000",
          "type": "STAKING",
          "stake": {
            "id": "72",
            "startTime": "2020-07-29T11:34:02Z",
            "endTime": "2020-07-29T14:15:09Z",
            "amount": "1000",
            "active": false
          }
        },
        {
          "timestamp": "2020-07-29T14:15:09Z",
          "amount": "1000",
          "type": "UNSTAKING",
          "stake": {
            "id": "72",
            "startTime": "2020-07-29T11:34:02Z",
            "endTime": "2020-07-29T14:15:09Z",
            "amount": "1000",
            "active": false
          }
        },
        {
          "timestamp": "2020-07-29T14:15:20Z",
          "amount": "-1000",
          "type": "STAKING",
          "stake": {
            "id": "73",
            "startTime": "2020-07-29T14:15:20Z",
            "endTime": null,
            "amount": "1000",
            "active": true
          }
        }
      ],
      "count": "string"
    }).then(
      (value) => (value['stakingHist'] as List)
          .map((e) => StakeHistoryEntity.fromMap(e))
          .toList(),
    );
  }
}
