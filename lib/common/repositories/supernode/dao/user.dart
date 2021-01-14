import 'package:supernodeapp/common/repositories/shared/clients/client.dart';
import 'package:supernodeapp/common/repositories/shared/dao/dao.dart';
import 'package:supernodeapp/common/repositories/supernode/dao/user.model.dart';
import 'package:supernodeapp/common/utils/url.dart';

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
}

class UserDao extends HttpDao {
  UserDao(HttpClient client) : super(client);

  //remote
  Future<dynamic> register(Map data) {
    return post(
      url: UserApi.registration,
      data: data,
    );
  }

  Future<RegistrationConfirmResponse> registerConfirm(Map data) {
    return post(
      url: UserApi.registrationConfirm,
      data: data,
    ).then((value) => RegistrationConfirmResponse.fromMap(value));
  }

  Future<dynamic> registerFinish(Map data, String token) {
    return post(
      url: UserApi.registrationFinish,
      headers: {'Grpc-Metadata-Authorization': token},
      data: data,
    );
  }

  Future<UserLoginResponse> login(String username, String password) {
    return post(
      url: UserApi.login,
      data: {
        'username': username,
        'password': password,
      },
    ).then((res) => UserLoginResponse.fromMap(res));

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
}
