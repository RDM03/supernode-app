
import 'package:supernodeapp/common/daos/dao.dart';

import 'api.dart';
import 'mock.dart';

class UserApi {
  static const String login = '/api/internal/login';
  static const String profile = '/api/internal/profile';
  static const String registration = '/api/internal/registration';
  static const String registrationConfirm = '/api/internal/registration-confirm';
  static const String registrationFinish = '/api/internal/registration-finish';

  static const String update = '/api/users/{user.id}';
  static const String password = '/api/users/{userId}/password';
}

class UserDao extends Dao{
  static const String table = 'users';
  static const String cId = 'cId';
  static const String id = 'id';
  static const String username = 'username';
  static const String password = 'password';
  static const String token = 'token';
  static const String isAdmin = 'isAdmin';
  static const String isActive = 'isActive';
  static const String email = 'email';
  static const String note = 'note';

  //remote
  Future<dynamic> register(Map data){
    return post(
      url: UserApi.registration,
      data: data,
    );
  }

  Future<dynamic> registerConfirm(Map data){
    return post(
      url: UserApi.registrationConfirm,
      data: data,
    );
  }

  Future<dynamic> registerFinish(Map data){
    return post(
      url: UserApi.registrationFinish,
      data: data,
    );
  }

  Future<dynamic> login(Map data){
    return post(
      url: UserApi.login,
      data: data,
    );
    
    //.then((res) => !isMock ? res : Mock.login)
    // .catchError((err) => !isMock ? err : Mock.login);
  }

  Future<dynamic> profile(){
    return get(
      url: UserApi.profile,
    ).then((res) => res);
  }

  Future<dynamic> update(Map data){
    return put(
      url: Api.url(UserApi.update, data['id']),
      data: data
    ).then((res) => res);
  }

  Future<dynamic> changePassword(Map data){
    return put(
      url: Api.url(UserApi.password, data['userId']),
      data: data
    ).then((res) => res);
  }
}