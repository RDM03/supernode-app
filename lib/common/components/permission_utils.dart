import 'package:location/location.dart';

class PermissionUtil {
  static Future<bool> getLocationPermission() async {
    final location = Location();
    final hasPermissions = await location.hasPermission();
    if (hasPermissions != PermissionStatus.granted) {
      var state = await location.requestPermission();
      return state == PermissionStatus.granted;
    }
    return true;
  }
}
