import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:supernodeapp/common/utils/auth.dart';

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

  SupernodeJwt get parsedJwt => parseJwt(jwt);
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
  final String orgDisplayName;
  final bool isAdmin;
  final bool isDeviceAdmin;
  final bool isGatewayAdmin;
  final String createdAt;
  final String upadatedAt;

  UserOrganization({
    this.organizationID,
    this.organizationName,
    this.orgDisplayName,
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
      orgDisplayName: map['organizationDisplayName'],
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
  final List<ExternalUser> externalUserAccounts;

  ProfileResponse({
    this.user,
    this.organizations,
    this.externalUserAccounts,
  });

  factory ProfileResponse.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return ProfileResponse(
      user: ProfileUser.fromMap(map['user']),
      organizations: List<UserOrganization>.from(
          map['organizations']?.map((x) => UserOrganization.fromMap(x))),
      externalUserAccounts: List<ExternalUser>.from(
          map['externalUserAccounts']?.map((x) => ExternalUser.fromMap(x))),
    );
  }

  factory ProfileResponse.fromJson(String source) =>
      ProfileResponse.fromMap(json.decode(source));
}

class ExternalUser {
  static const String weChatService = 'wechat';
  static const String shopifyService = 'shopify';

  final String externalUserId;
  final String externalUsername;
  final String service;

  ExternalUser({
    this.externalUserId,
    this.externalUsername,
    this.service,
  });

  factory ExternalUser.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return ExternalUser(
      externalUserId: map['externalUserId'],
      externalUsername: map['externalUsername'],
      service: map['service'],
    );
  }

  factory ExternalUser.fromJson(String source) =>
      ExternalUser.fromMap(json.decode(source));

  ExternalUser copyWith({
    String externalUserId,
    String externalUsername,
    String service,
  }) {
    return ExternalUser(
      externalUserId: externalUserId ?? this.externalUserId,
      externalUsername: externalUsername ?? this.externalUsername,
      service: service ?? this.service,
    );
  }
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

class TotpEnabledResponse {
  final bool enabled;

  TotpEnabledResponse(this.enabled);

  factory TotpEnabledResponse.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return TotpEnabledResponse(
      map['enabled'],
    );
  }
}

class FiatCurrency {
  final String id;
  final String description;

  FiatCurrency(this.id, this.description);

  factory FiatCurrency.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return FiatCurrency(
      map['id'],
      map['description']
    );
  }
}

Future<String> createFile(Map<String, dynamic> map, String fileName) async {
  final String dir = (await getExternalStorageDirectory()).path;
  final String fullPath = '$dir/$fileName';
  final File report = new File(fullPath);
  report.openWrite(mode: FileMode.write);
  await report.writeAsBytes(base64.decode(map['data']), flush: true);

  return fullPath;
}