import 'dart:convert';

class UserLoginResponse {
  final bool is2faRequired;
  final String jwt;

  UserLoginResponse({
    this.is2faRequired = false,
    this.jwt,
  });

  factory UserLoginResponse.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return UserLoginResponse(
      is2faRequired: map['is2faRequired'],
      jwt: map['jwt'],
    );
  }

  SupernodeJwt get parsedJwt {
    if (jwt == null) return null;
    final splitted = jwt.split('.');
    if (splitted.length < 2) return null;
    final encoded = splitted[1];
    final json = utf8.decode(base64.decode(encoded));
    return SupernodeJwt.fromJson(json);
  }
}

class SupernodeJwt {
  final int userId;
  final String username;

  SupernodeJwt(this.userId, this.username);

  factory SupernodeJwt.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return SupernodeJwt(
      map['userId'],
      map['username'],
    );
  }

  factory SupernodeJwt.fromJson(String source) =>
      SupernodeJwt.fromMap(json.decode(source));
}

class RegistrationConfirmResponse {
  final String id;
  final bool isActive;
  final bool isAdmin;
  final String jwt;
  final int sessionTtl;
  final String username;

  RegistrationConfirmResponse({
    this.id,
    this.isActive,
    this.isAdmin,
    this.jwt,
    this.sessionTtl,
    this.username,
  });

  factory RegistrationConfirmResponse.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return RegistrationConfirmResponse(
      id: map['id'],
      isActive: map['isActive'],
      isAdmin: map['isAdmin'],
      jwt: map['jwt'],
      sessionTtl: map['sessionTTL'],
      username: map['username'],
    );
  }
}
