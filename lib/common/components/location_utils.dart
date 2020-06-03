import 'package:amap_location_fluttify/amap_location_fluttify.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationUtils {
  factory LocationUtils() => instance;

  LocationUtils._();

  static final LocationUtils instance = LocationUtils._();
  static Location _location;
  static Location get loc => _location;

  static Future<bool> requestPermission() async {
    final permissions = await PermissionHandler().requestPermissions([PermissionGroup.location]);
    if (permissions[PermissionGroup.location] == PermissionStatus.granted) {
      return true;
    } else {
      return false;
    }
  }

  static Future<Location> getMyLocation() async {
    await AmapCore.init('85fad6510f365f60aabc6adcf3f78ac8');
    _location = await AmapLocation.fetchLocation();
    return _location;
  }
}
