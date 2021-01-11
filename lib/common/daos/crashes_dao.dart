import 'dart:convert';
import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:dio/dio.dart';
import 'package:package_info/package_info.dart';
import 'package:supernodeapp/common/utils/uuid.dart';
import 'package:supernodeapp/configs/sys.dart';

class CrashesDao {
  static Dio dio = new Dio();

  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  String appLaunchTimestamp = '';
  Map device = {};
  String deviceId = '';

  String type = Platform.isAndroid
      ? 'handledError'
      : 'appleError'; //The handledError is for android, the appleError is for iOS.

  // initialization
  void init({String appSecretAndroid, String appSecretIOS}) async {
    dio.options.headers = {
      // 'Content-Type': 'application/json',
      'app-secret': Platform.isAndroid ? appSecretAndroid : appSecretIOS,
      'install-id': Uuid().generateV4()
    };

    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;

    this.appLaunchTimestamp = DateTime.now().toIso8601String() + 'Z';

    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      deviceId = androidInfo.androidId;
      this.device = {
        "appVersion": version,
        "appBuild": buildNumber,
        "sdkName": androidInfo.fingerprint,
        "sdkVersion": androidInfo.fingerprint,
        "osName": androidInfo.brand,
        "osVersion": androidInfo.version.release,
        "model": androidInfo.model,
        "locale": Platform.localeName
      };
    } else {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      deviceId = iosInfo.identifierForVendor;
      this.device = {
        "appVersion": version,
        "appBuild": buildNumber,
        "sdkName": iosInfo.utsname.sysname,
        "sdkVersion": iosInfo.utsname.release,
        "osName": iosInfo.systemName,
        "osVersion": iosInfo.systemVersion,
        "model": iosInfo.model,
        "locale": Platform.localeName
      };
    }
  }

  void upload(dynamic err, {String userId = '', dynamic options}) async {
    var now = DateTime.now().toIso8601String() + 'Z';
    var data;

    if (Platform.isAndroid) {
      data = {
        "logs": [
          {
            "type": "handledError",
            "timestamp": now,
            "appLaunchTimestamp": this.appLaunchTimestamp,
            "id": Uuid().generateV4(),
            "device": this.device,
            "userId": "$userId-${this.deviceId}",
            "exception": {
              "type": "System.IO.AIPsException",
              "message":
                  "${err['message']}:${err['code']} ext: $userId-${this.deviceId}",
              "stackTrace": "${options.baseUrl}${options.path}",
              "innerExceptions": []
            }
          }
        ]
      };
    } else {
      data = {
        "logs": [
          {
            "id": Uuid().generateV4(),
            "type": this.type,
            "timestamp": now,
            "appLaunchTimestamp": this.appLaunchTimestamp,
            "device": this.device,
            "userId": "$userId-${this.deviceId}",
            "applicationPath": "iOS/salesforce",
            "osExceptionType": "APIsIssue",
            "osExceptionCode": "0",
            "osExceptionAddress": "0x00",
            "processName": "salesforce",
            "fatal": false,
            "isTestMessage": false,
            "binaries": [
              {
                "id": Uuid().generateV4(),
                "name":
                    "${err['message']}:${err['code']} ext: $userId-${this.deviceId}",
                "startAddress": "",
                "endAddress": "",
                "path": "${options.baseUrl}${options.path}",
                "primaryArchitectureId": 0,
                "architectureVariantId": 0
              },
            ]
          }
        ]
      };
    }

    try {
      dio.post(Sys.crasheslog, data: JsonEncoder().convert(data));
    } catch (err) {
      print('---crashes---:$err');
    }
  }

  // singleton
  factory CrashesDao() => _getInstance();

  static CrashesDao get instance => _getInstance();
  static CrashesDao _instance;

  CrashesDao._internal();

  static CrashesDao _getInstance() {
    if (_instance == null) {
      _instance = new CrashesDao._internal();
      dio.options.baseUrl = Sys.crashesUrl;
    }
    return _instance;
  }
}
