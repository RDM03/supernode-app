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
    var encoded = splitted[1];

    // need to add tail, otherwise base64 throws.
    switch (encoded.length % 4) {
      case 1:
        break;
      case 2:
        encoded += "==";
        break;
      case 3:
        encoded += "=";
        break;
    }
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

class UserOrganization {
  final String organizationID;
  final String organizationName;
  final bool isAdmin;
  final bool isDeviceAdmin;
  final bool isGatewayAdmin;
  final String createdAt;
  final String upadatedAt;

  UserOrganization({
    this.organizationID,
    this.organizationName,
    this.isAdmin,
    this.isDeviceAdmin,
    this.createdAt,
    this.upadatedAt,
    this.isGatewayAdmin,
  });

  factory UserOrganization.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return UserOrganization(
      organizationID: map['organizationID'],
      organizationName: map['organizationName'],
      isAdmin: map['isAdmin'],
      isDeviceAdmin: map['isDeviceAdmin'],
      isGatewayAdmin: map['isGatewayAdmin'],
      createdAt: map['createdAt'],
      upadatedAt: map['upadatedAt'],
    );
  }

  factory UserOrganization.fromJson(String source) =>
      UserOrganization.fromMap(json.decode(source));
}

class ProfileResponse {
  final ProfileUser user;
  final List<UserOrganization> organizations;

  ProfileResponse({this.user, this.organizations});

  factory ProfileResponse.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return ProfileResponse(
      user: ProfileUser.fromMap(map['user']),
      organizations: List<UserOrganization>.from(
          map['organizations']?.map((x) => UserOrganization.fromMap(x))),
    );
  }

  factory ProfileResponse.fromJson(String source) =>
      ProfileResponse.fromMap(json.decode(source));
}

class ProfileUser {
  final String email;
  final String admin;
  final bool isActive;
  final bool isAdmin;
  final String lastLoginService;
  final String note;
  final int sessionTTL;
  final String username;

  ProfileUser({
    this.email,
    this.admin,
    this.isActive,
    this.isAdmin,
    this.lastLoginService,
    this.note,
    this.sessionTTL,
    this.username,
  });

  factory ProfileUser.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return ProfileUser(
      email: map['email'],
      admin: map['admin'],
      isActive: map['isActive'],
      isAdmin: map['isAdmin'],
      lastLoginService: map['lastLoginService'],
      note: map['note'],
      sessionTTL: map['sessionTTL'],
      username: map['username'],
    );
  }

  factory ProfileUser.fromJson(String source) =>
      ProfileUser.fromMap(json.decode(source));
}
