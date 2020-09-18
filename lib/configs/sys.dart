class AppLanguage {
  static const String auto       = 'auto';
  static const String en         = 'en';
  static const String en_CN      = 'en_CN';
  static const String zh_Hans_CN = 'zh_CN';
  static const String zh_Hant_TW = 'zh_TW';
  static const String zh_Hant_HK = 'zh_HK';
  static const String ko         = 'ko';
  static const String ja         = 'ja';
  static const String tr         = 'tr';
  static const String de         = 'de';
  static const String ru         = 'ru';
  static const String vi         = 'vi';
}

class Sys {
  /// Main Menus
  static const List<String> mainMenus = ['Home', 'Gateway', 'Device', 'Wallet'];

  /// Using the Test Url When debugging
  static const testBaseUrl  = 'https://lora.test.cloud.mxc.org';
  static const buildBaseUrl = 'https://lora.build.cloud.mxc.org';

  /// Using in the About Page and the Registration Page
  static const impressum     = 'https://www.mxc.org/imprint';
  static const privacyPolicy = 'https://www.mxc.org/privacy-policy';
  static const agreePolicy   = 'https://www.mxc.org/terms-and-conditions';
  static const stakeMore     = 'https://mxc.wiki';

  /// AppCenter Config of init method
  static const appSecretAndroid   = '85fbe3cf-0680-4024-b047-ae781c95bd9d';
  static const appSecretIOS       = 'f69d3fff-c177-4cef-81bd-b306f910edd7';
  static const tokenAndroid       = '46ace79c8ecee96614144c982707714ea385a1d1';
  static const tokenIOS           = 'e7eb9a0389dd31bf39ee13fef12e7b8a5a62b130';
  static const appIdIOS           = '1509218470';
  static const betaUrlIOS         = 'itms-beta://testflight.apple.com/join/NkXHEpf4';
  static const downloadUrlAndroid = 'https://datadash.oss-accelerate.aliyuncs.com/app-prod-release.apk';
  static const channelProduct     = 'prod';
  static const channelGooglePlay  = 'play';

  /// Mapbox
  static const mapTileStyle   = "mapbox://styles/mxcdatadash/ck9qr005y5xec1is8yu6i51kw";
  static const mapUrlTemplate = 'https://api.mapbox.com/styles/v1/mxcdatadash/ck9qr005y5xec1is8yu6i51kw/tiles/256/{z}/{x}/{y}@2x?access_token={accessToken}';
  static const mapToken       = 'pk.eyJ1IjoibXhjZGF0YWRhc2giLCJhIjoiY2s5bnc4dmh4MDBiMDNnbnczamRoN2ExeCJ9.sq0w8DGDXpA_6AMoejYaUw';
  static const mapboxjs       = 'assets/js/mapbox-gl.js';
  static const mapjs          = 'assets/js/map.js';

  /// Crashes
  static const crashesUrl = 'https://in.appcenter.ms';
  static const crasheslog = '/logs?Api-Version=1.0.0';

  /// Load data of the location of global gateways 
  static const gateways_location_list = 'assets/others/global_gateways_location.json';
}
