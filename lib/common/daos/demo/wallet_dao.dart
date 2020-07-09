import 'package:supernodeapp/common/daos/app_dao.dart';
import 'package:supernodeapp/common/daos/demo/demo_dao.dart';
import 'package:supernodeapp/common/daos/demo/user_dao.dart';

class DemoWalletDao extends DemoDao implements WalletDao {
  @override
  Future balance(Map data) async {
    return Future.value({
      'balance': 0,
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
  Future miningIncome(Map data) async {
    return Future.value({
      'miningIncome': 10,
      'userProfile': await DemoUserDao().profile(),
    });
  }
}
