import 'package:supernodeapp/common/daos/dao.dart';

import 'api.dart';

class UserApi {
  static const String login = '/api/internal/login';
  static const String profile = '/api/internal/profile';
  static const String registration = '/api/internal/registration';
  static const String registrationConfirm =
      '/api/internal/registration-confirm';
  static const String registrationFinish = '/api/internal/registration-finish';

  static const String update = '/api/users/{user.id}';
  static const String password = '/api/users/{userId}/password';

  static const String getTOTPStatus = '/api/internal/totp-status';
  static const String getTOTPConfig = '/api/internal/totp-configuration';
  static const String setEnable =
      '/api/internal/totp-enable'; //OTP code in Grpc-Metadata-X-OTP header
  static const String setDisable = '/api/internal/totp-disable';

  static const String passwordReset = "/api/internal/request-password-reset";
  static const String passwordResetConfirm =
      "/api/internal/confirm-password-reset";

  //ExternalUserService
  static const String authenticateWeChatUser = "/api/external-login/authenticate-wechat-user";
  static const String bindExternalUser = "/api/external-login/bind-external-user";
}

class UserDao extends Dao {
  static const String table = 'users';
  static const String cId = 'cId';
  static const String id = 'id';
  static const String username = 'username';
  static const String password = 'password';
  static const String token = 'token';
  static const String isAdmin = 'isAdmin';
  static const String isActive = 'isActive';
  static const String isDemo = 'isDemo';
  static const String email = 'email';
  static const String note = 'note';

  //remote
  Future<dynamic> register(Map data) {
    return post(
      url: UserApi.registration,
      data: data,
    );
  }

  Future<dynamic> registerConfirm(Map data) {
    return post(
      url: UserApi.registrationConfirm,
      data: data,
    );
  }

  Future<dynamic> registerFinish(Map data) {
    return post(
      url: UserApi.registrationFinish,
      data: data,
    );
  }

  Future<dynamic> login(Map data) {
    return post(
      url: UserApi.login,
      data: data,
    );

    //.then((res) => !isMock ? res : Mock.login)
    // .catchError((err) => !isMock ? err : Mock.login);
  }

  Future<dynamic> profile() {
    return get(
      url: UserApi.profile,
    );
  }

  Future<dynamic> update(Map data) {
    return put(url: Api.url(UserApi.update, data['id']), data: data)
        .then((res) => res);
  }

  Future<dynamic> changePassword(Map data) {
    return put(url: Api.url(UserApi.password, data['userId']), data: data)
        .then((res) => res);
  }

  //get TOTP Status by Namgyeong
  Future<dynamic> getTOTPStatus(Map data) {
    return get(url: UserApi.getTOTPStatus, data: data).then((res) => res);
  }

  Future<dynamic> getTOTPConfig(Map data) {
    return post(url: UserApi.getTOTPConfig, data: data).then((res) => res);
  }

  Future<dynamic> setEnable(Map data) {
    return post(url: UserApi.setEnable, data: data).then((res) => res);
  }

  Future<dynamic> setDisable(Map data) {
    return post(url: UserApi.setDisable, data: data).then((res) => res);
  }

  Future<dynamic> passwordReset(Map data) {
    return post(url: UserApi.passwordReset, data: data);
  }

  Future<dynamic> passwordResetConfirm(Map data) {
    return post(url: UserApi.passwordResetConfirm, data: data);
  }

  Future<dynamic> authenticateWeChatUser(Map data) {
    return post(url: UserApi.authenticateWeChatUser, data: data);
  }

  Future<dynamic> bindExternalUser(Map data) {
    return post(url: UserApi.bindExternalUser, data: data);
  }
}
