import 'demo.dart';
import '../user.dart';
import '../user.model.dart';

class DemoUserDao extends DemoDao implements UserDao {
  static const String username = 'demo user';

  @override
  Future getTOTPStatus(Map data) {
    return Future.value({
      'enabled': true,
    });
  }

  @override
  Future<ProfileResponse> profile() {
    return Future.value(ProfileResponse(
        user: ProfileUser.fromMap({
          'id': 'demo',
          'username': username,
          'sessionTTL': 0,
          'isAdmin': false,
          'isActive': true,
          'isDemo': true,
          'email': 'demo@email.net',
          'note': 'User used for demo',
        }),
        organizations: [
          UserOrganization(
            createdAt: '2020-07-09T15:23:33.162Z',
            upadatedAt: '2021-01-14T15:23:33.162Z',
            isAdmin: false,
            isDeviceAdmin: false,
            isGatewayAdmin: false,
            organizationID: 'demo-organization',
            organizationName: 'Demo organization',
          )
        ]));
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
  Future<UserLoginResponse> login(String username, String password) {
    return Future.value(UserLoginResponse(jwt: 'demo-jwt'));
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

  @override
  Future<RegistrationConfirmResponse> registerConfirm(Map data) {
    throw UnimplementedError('registerConfirm not supported in demo');
  }

  @override
  Future registerFinish(Map data, String token) {
    throw UnimplementedError('registerFinish not supported in demo');
  }

  @override
  Future authenticateWeChatUser(Map data) {
    throw UnimplementedError();
  }

  @override
  Future bindExternalUser(Map data) {
    throw UnimplementedError();
  }

  @override
  Future debugAuthenticateWeChatUser(Map data) {
    throw UnimplementedError();
  }

  @override
  Future registerExternalUser(Map data) {
    throw UnimplementedError();
  }

  @override
  Future unbindExternalUser(Map data) {
    throw UnimplementedError();
  }
}
