import 'dart:io';

import 'demo.dart';
import '../user.dart';

class DemoUserDao extends DemoDao implements UserDao {
  static const String username = 'demo user';

  @override
  Future<TotpEnabledResponse> getTOTPStatus() {
    return Future.value(TotpEnabledResponse(true));
  }

  @override
  Future<ProfileResponse> profile() {
    return Future.value(ProfileResponse(
        externalUserAccounts: [],
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
  Future<TotpEnabledResponse> setEnable(String code) {
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

  Future<dynamic> verifyExternalEmail(Map data) {
    throw UnimplementedError('binding not supported in demo');
  }

  Future<dynamic> confirmExternalEmail(Map data) {
    throw UnimplementedError('binding not supported in demo');
  }

  Future<List<FiatCurrency>> supportedFiatCurrencies() {
    return Future.value([
      FiatCurrency('usd', 'usd'),
      FiatCurrency('eur', 'eur'),
      FiatCurrency('cny', 'cny')
    ]);
  }

  Future<String> miningIncomeReport(Map data) {
    throw UnimplementedError('binding not supported in demo');
  }
}
