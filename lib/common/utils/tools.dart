import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:url_launcher/url_launcher.dart';

class Tools {
  static String hideHalf(String source) {
    String newSource = '';
    int endLength = source.length;

    if (endLength == 0 || endLength == 1) {
      return '*';
    }

    int lastLength = endLength > 6 ? 4 : 1;
    int halfLength = (endLength / 2).floor();

    if (endLength > 60) {
      halfLength = (endLength / 10).floor();
    }

    newSource = source.replaceRange(halfLength, endLength - lastLength, '...');

    return newSource;
  }

  static LatLng convertLatLng(Map location){

    if(location['latitude'] is String){
      location['latitude'] = double.parse(location['latitude']);
      location['longitude'] = double.parse(location['longitude']);
    }

    return LatLng(
        location['latitude'].toDouble(), location['longitude'].toDouble());
  }

  static Future<void> launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  static String priceFormat(double number, {int range = 1}) {
    String newNumber = number?.toStringAsFixed((range + 1)) ?? '0.0';
    return newNumber.substring(0,newNumber.lastIndexOf('.') + range + 1);
  }

  static double convertDouble(dynamic number) {
    if (number == null) return null;
    if (number is double) return number;
    return double.parse(number.toString());
  }

  static String dateFormat(DateTime date) {
    if (date == null) return '?';
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    return '${date.year}-$month-$day';
  }
}
