class Mock{
  static const Map login = {
    "jwt": "string"
  };

  static const Map gateways = {
  'list': {
    "totalCount": "123",
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
  }};

  static const Map stakeHistory = {
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
            "createdAt": "2020-04-17T14:21:23.693Z",
            "updatedAt": "2020-04-17T14:21:23.693Z"
          }
        ],
        "settings": {
          "disableAssignExistingUsers": true
        }
      },
      "stakingHist": [
        {
          "stakeAmount": 120,
          "start": "2020-04-15T13:01:41.617Z",
          "end": "2020-04-15T13:01:41.617Z",
          "revMonth": "string",
          "networkIncome": 0,
          "monthlyRate": 0,
          "revenue": 0,
          "balance": 0
        },
        {
          "stakeAmount": 110,
          "start": "2020-04-15T13:01:41.617Z",
          "end": "",
          "revMonth": "string",
          "networkIncome": 0,
          "monthlyRate": 0,
          "revenue": 0,
          "balance": 0
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
        "settings": {
          "disableAssignExistingUsers": true
        }
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
      "id": "string",
      "fkWallet": "string",
      "amount": 10,
      "stakeStatus": "string",
      "startStakeTime": "2020-04-27T09:44:56.286Z",
      "unstakeTime": "2020-04-27T09:44:56.286Z"
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
      "settings": {
        "disableAssignExistingUsers": true
      }
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
      "settings": {
        "disableAssignExistingUsers": true
      }
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