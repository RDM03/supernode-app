import 'package:supernodeapp/common/repositories/supernode/dao/wallet.model.dart';

import 'demo.dart';
import '../wallet.dart';
import 'user.dart';

class DemoWalletDao extends DemoDao implements WalletDao {
  @override
  Future balance(Map data) async {
    String bal = '20180706';
    if (data['currency'] == 'DHX') bal = '220078';
    if (data['currency'] == 'BTC') bal = '0.1034';
    return Future.value({
      'balance': bal,
      'userProfile': await DemoUserDao().profile(),
    });
  }

  @override
  Future convertUSD(Map data) {
    return Future.value({
      'mxcPrice': '200',
    });
  }

  @override
  Future history(Map data) {
    return Future.value({
      'count': 'DEPOSIT',
      'txHistory': [
        {
          'from': '123456789009866',
          'to': '123456789009866',
          'txType': 'DEPOSIT',
          'amount': 1230,
          'createdAt': '2020-06-15T13:01:41.617Z'
        },
        {
          'from': '123456789009866',
          'to': '123456789009866',
          'txType': 'WITHDRAW',
          'amount': 231,
          'createdAt': '2020-06-15T13:01:41.617Z'
        }
      ],
      'userProfile': {
        'user': {
          'id': 'string',
          'username': 'string',
          'sessionTTL': 0,
          'isAdmin': true,
          'isActive': true,
          'email': 'string',
          'note': 'string'
        },
        'organizations': [
          {
            'organizationID': 'string',
            'organizationName': 'string',
            'isAdmin': true,
            'isDeviceAdmin': true,
            'isGatewayAdmin': true,
            'createdAt': '2020-04-17T13:35:07.211Z',
            'updatedAt': '2020-04-17T13:35:07.211Z'
          }
        ],
        'settings': {'disableAssignExistingUsers': true}
      }
    });
  }

  @override
  Future historyTransaction(Map data) {
    return Future.value({
      "tx": [
        {
          "amount": "1",
          "detailsJson": "string",
          "id": "1",
          "paymentType": "DHX_UNBONDING",
          "timestamp": "2021-06-15T09:01:19.057Z"
        },
        {
          "amount": "1",
          "detailsJson": "string",
          "id": "1",
          "paymentType": "DHX_UNBONDING",
          "timestamp": DateTime.now().add(Duration(days: -1)).toUtc().toIso8601String()
        }
      ]
    });
  }

  @override
  Future miningIncome(Map data) async {
    return Future.value({
      'miningIncome': 10,
      'userProfile': await DemoUserDao().profile(),
    });
  }

  @override
  Future miningInfo(Map data) {
    return Future.value({
      "todayRev": 10,
      "data": [
        {"month": "January", "amount": "10.0"},
        {"month": "February", "amount": "8.0"},
        {"month": "March", "amount": "7.0"},
        {"month": "April", "amount": "8.0"},
        {"month": "May", "amount": "10.0"},
        {"month": "June", "amount": "5.0"},
        {"month": "July", "amount": "12.0"},
        {"month": "July", "amount": "13.0"},
        {"month": "August", "amount": "13.0"},
        {"month": "September", "amount": "8.0"},
        {"month": "October", "amount": "8.0"},
        {"month": "November", "amount": "9.0"},
        {"month": "December", "amount": "10.0"},
      ]
    });
  }

  @override
  Future<MiningIncomeGatewayResponse> miningIncomeGateway({
    String gatewayMac,
    String orgId,
    DateTime fromDate,
    DateTime tillDate,
  }) {
    return Future.value(MiningIncomeGatewayResponse.fromMap({
      "total": "100",
      "dailyStats": [
        // {
        //   "date": DateTime.now()
        //       .add(Duration(
        //         days: -8,
        //       ))
        //       .toUtc()
        //       .toIso8601String(),
        //   "amount": "300.0",
        //   "onlineSeconds": "10",
        // },
        {
          "date": DateTime.now()
              .add(Duration(
                days: -7,
              ))
              .toUtc()
              .toIso8601String(),
          "amount": "350.0",
          "onlineSeconds": "11",
        },
        {
          "date": DateTime.now()
              .add(Duration(
                days: -6,
              ))
              .toUtc()
              .toIso8601String(),
          "amount": "358.0",
          "onlineSeconds": "6",
        },
        {
          "date": DateTime.now()
              .add(Duration(
                days: -5,
              ))
              .toUtc()
              .toIso8601String(),
          "amount": "420.0",
          "onlineSeconds": "30",
        },
        {
          "date": DateTime.now()
              .add(Duration(
                days: -4,
              ))
              .toUtc()
              .toIso8601String(),
          "amount": "430.0",
          "onlineSeconds": "9",
        },
        {
          "date": DateTime.now()
              .add(Duration(
                days: -3,
              ))
              .toUtc()
              .toIso8601String(),
          "amount": "400.0",
          "onlineSeconds": "7",
        },
        {
          "date": DateTime.now()
              .add(Duration(
                days: -2,
              ))
              .toUtc()
              .toIso8601String(),
          "amount": "380.0",
          "onlineSeconds": "3",
        },
        {
          "date": DateTime.now()
              .add(Duration(
                days: -1,
              ))
              .toUtc()
              .toIso8601String(),
          "amount": "380.0",
          "onlineSeconds": "3",
        },
      ]
    }));
  }

  @override
  Future<void> topUpMiningFuel(
      {String currency, String orgId, List<GatewayAmountRequest> topUps}) {
    return Future.value();
  }

  @override
  Future<void> withdrawMiningFuel(
      {String currency, String orgId, List<GatewayAmountRequest> withdraws}) {
    return Future.value();
  }

  @override
  Future<double> downlinkPrice(String orgId) {
    return Future.value(404.0);
  }
}
