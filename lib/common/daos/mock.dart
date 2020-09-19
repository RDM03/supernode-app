class Mock {
  static const Map login = {"jwt": "string"};

  static const Map gateways = {
    'list': {
      "totalCount": "2",
      "result": [
        {
          "id": "1",
          "name": "gateways",
          "description": "string",
          "createdAt": "2020-04-15T13:01:41.617Z",
          "updatedAt": "2020-04-15T13:01:41.617Z",
          "firstSeenAt": "2020-04-15T13:01:41.617Z",
          "lastSeenAt": "2020-04-15T13:01:41.617Z",
          "organizationID": "organizationID",
          "networkServerID": "networkServerID",
          "location": {
            "latitude": 0,
            "longitude": 0,
            "altitude": 0,
            "source": "UNKNOWN",
            "accuracy": 0
          }
        },
        {
          "id": "2",
          "name": "gateways2",
          "description": "string",
          "createdAt": "2020-04-15T13:01:41.617Z",
          "updatedAt": "2020-04-15T13:01:41.617Z",
          "firstSeenAt": "2020-04-15T13:01:41.617Z",
          "lastSeenAt": "2020-04-15T13:01:41.617Z",
          "organizationID": "organizationID",
          "networkServerID": "networkServerID",
          "location": {
            "latitude": 0,
            "longitude": 0,
            "altitude": 0,
            "source": "UNKNOWN",
            "accuracy": 200
          }
        }
      ]
    }
  };

  static const Map stakeHistory = {
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
  };

  static const Map topup = {
    'history': {
      "count": "100",
      "topupHistory": [
        {
          "amount": 0,
          "createdAt": "2020-04-15T13:01:41.617Z",
          "txHash": "12345612346123456"
        },
        {
          "amount": 10,
          "createdAt": "2020-04-15T13:01:41.617Z",
          "txHash": "12345612346123456"
        }
      ]
    }
  };

  static const Map wallet = {
    'history': {
      "count": "DEPOSIT",
      "txHistory": [
        {
          "from": "123456789009866",
          "to": "123456789009866",
          "txType": "DEPOSIT",
          "amount": 1230,
          "createdAt": "2020-06-15T13:01:41.617Z"
        },
        {
          "from": "123456789009866",
          "to": "123456789009866",
          "txType": "WITHDRAW",
          "amount": 231,
          "createdAt": "2020-06-15T13:01:41.617Z"
        }
      ],
      "userProfile": {
        "user": {
          "id": "string",
          "username": "string",
          "sessionTTL": 0,
          "isAdmin": true,
          "isActive": true,
          "email": "string",
          "note": "string"
        },
        "organizations": [
          {
            "organizationID": "string",
            "organizationName": "string",
            "isAdmin": true,
            "isDeviceAdmin": true,
            "isGatewayAdmin": true,
            "createdAt": "2020-04-17T13:35:07.211Z",
            "updatedAt": "2020-04-17T13:35:07.211Z"
          }
        ],
        "settings": {"disableAssignExistingUsers": true}
      }
    }
  };

  static const Map withdraw = {
    'history': {
      "count": "string",
      "withdrawHistory": [
        {
          "amount": 0,
          "txSentTime": "2020-03-15T13:01:41.617Z",
          "txStatus": "Success",
          "txHash": "654321123456654321",
          "denyComment": "Success"
        },
        {
          "amount": 1,
          "txSentTime": "2020-05-15T13:01:41.617Z",
          "txStatus": "Fail",
          "txHash": "654321123456654321",
          "denyComment": "string"
        }
      ]
    }
  };

  static const Map activestakes = {
    "actStake": {
      "Id": "string",
      "FkWallet": "string",
      "Amount": 20200706,
      "StakeStatus": "string",
      "StartStakeTime": "2020-04-27T09:44:56.286Z",
      "UnstakeTime": "2020-04-27T09:44:56.286Z"
    },
    "userProfile": {
      "user": {
        "id": "string",
        "username": "string",
        "sessionTTL": 0,
        "isAdmin": true,
        "isActive": true,
        "email": "string",
        "note": "string"
      },
      "organizations": [
        {
          "organizationID": "string",
          "organizationName": "string",
          "isAdmin": true,
          "isDeviceAdmin": true,
          "isGatewayAdmin": true,
          "createdAt": "2020-04-27T09:44:56.286Z",
          "updatedAt": "2020-04-27T09:44:56.286Z"
        }
      ],
      "settings": {"disableAssignExistingUsers": true}
    }
  };

  static const Map unstake = {
    "userProfile": {
      "user": {
        "id": "string",
        "username": "string",
        "sessionTTL": 0,
        "isAdmin": true,
        "isActive": true,
        "email": "string",
        "note": "string"
      },
      "organizations": [
        {
          "organizationID": "string",
          "organizationName": "string",
          "isAdmin": true,
          "isDeviceAdmin": true,
          "isGatewayAdmin": true,
          "createdAt": "2020-04-27T09:06:25.511Z",
          "updatedAt": "2020-04-27T09:06:25.511Z"
        }
      ],
      "settings": {"disableAssignExistingUsers": true}
    },
    "stakingHist": [
      {
        "stakeAmount": 0,
        "start": "string",
        "end": "string",
        "revMonth": "string",
        "networkIncome": 0,
        "monthlyRate": 0,
        "revenue": 0,
        "balance": 0
      }
    ],
    "count": "string"
  };
}
