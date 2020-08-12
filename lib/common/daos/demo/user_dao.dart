import 'demo_dao.dart';
import '../users_dao.dart';

class DemoUserDao extends DemoDao implements UserDao {
  static const String username = 'demo user';

  @override
  Future getTOTPStatus(Map data) {
    return Future.value({
      'enabled': true,
    });
  }

  @override
  Future profile() {
    return Future.value({
      'user': {
        'id': 'demo',
        'username': username,
        'sessionTTL': 0,
        'isAdmin': false,
        'isActive': true,
        'isDemo': true,
        'email': 'demo@email.net',
        'note': 'User used for demo',
      },
      'organizations': [
        {
          'organizationID': 'demo-organization',
          'organizationName': 'Demo organization',
          'isAdmin': false,
          'isDeviceAdmin': false,
          'isGatewayAdmin': false,
          'createdAt': '2020-07-09T15:23:33.162Z',
          'updatedAt': '2020-07-09T15:23:33.162Z'
        }
      ],
      'settings': {'disableAssignExistingUsers': true}
    });
  }

  @override
  Future changePassword(Map data) {
    throw UnimplementedError('changePassword not supported in demo');
  }

  @override
  Future getTOTPConfig(Map data) {
    throw UnimplementedError('getTOTPConfig not supported in demo');
  }

  @override
  Future login(Map data) {
    return Future.value({'jwt': 'demo', 'isDemo': true});
  }

  @override
  Future passwordReset(Map data) {
    throw UnimplementedError('passwordReset not supported in demo');
  }

  @override
  Future passwordResetConfirm(Map data) {
    throw UnimplementedError('passwordResetConfirm not supported in demo');
  }

  @override
  Future register(Map data) {
    throw UnimplementedError('register not supported in demo');
  }

  @override
  Future registerConfirm(Map data) {
    throw UnimplementedError('registerConfirm not supported in demo');
  }

  @override
  Future registerFinish(Map data) {
    throw UnimplementedError('registerFinish not supported in demo');
  }

  @override
  Future setDisable(Map data) {
    throw UnimplementedError('setDisable not supported in demo');
  }

  @override
  Future setEnable(Map data) {
    throw UnimplementedError('setEnable not supported in demo');
  }

  @override
  Future update(Map data) {
    throw UnimplementedError('update not supported in demo');
  }
}
