class AppLanguage {
  static const String auto = 'auto';
  static const String en = 'en';
  static const String en_CN = 'en_CN';
  static const String zh_Hans_CN = 'zh_CN';
  static const String zh_Hant_TW = 'zh_TW';
  static const String ko = 'ko';
  static const String ja = 'ja';

  static const String tr = 'tr';
  static const String de = 'de';
  static const String ru = 'ru';
  static const String vi = 'vi';
}

class Sys {
  static const Map superNodes = {
    'xinyu': 'https://mxcxy.com',
    'huawei': 'https://lora.hunanhuaweikeji.com',
    'matchx': 'https://lora.supernode.matchx.io',
    'enlink': 'https://lora.rosanetworks.com',
  };

  static const testBaseUrl = 'https://lora.test.cloud.mxc.org';
  static const buildBaseUrl = 'https://lora.build.cloud.mxc.org';

  static const impressum = 'https://www.mxc.org/imprint';
  static const privacyPolicy = 'https://www.mxc.org/privacy-policy';
  static const AgreePolicy = 'https://www.mxc.org/terms-and-conditions';
  static const stakeMore = 'https://mxc.wiki';

  static const List<String> mainMenus = ['Home', 'Gateway', 'Device', 'Wallet'];

  static const mapUrlTemplate =
      'https://api.mapbox.com/styles/v1/mxcdatadash/ck9qr005y5xec1is8yu6i51kw/tiles/256/{z}/{x}/{y}@2x?access_token={accessToken}';
  static const mapToken =
      'pk.eyJ1IjoibXhjZGF0YWRhc2giLCJhIjoiY2s5bnc4dmh4MDBiMDNnbnczamRoN2ExeCJ9.sq0w8DGDXpA_6AMoejYaUw';

  static const iOSAppIdAppCenter = 'f69d3fff-c177-4cef-81bd-b306f910edd7';
  static const androidAppIdAppCenter = '85fbe3cf-0680-4024-b047-ae781c95bd9d';
}
