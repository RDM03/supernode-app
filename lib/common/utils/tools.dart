import 'package:latlong/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

class Tools {
  static String hideHalf(String source){
    String newSource = '';
    int endLength = source.length;

    if(endLength == 0 || endLength == 1){
      return '*';
    } 

    int lastLength = endLength > 6 ? 4 : 1;
    int halfLength = ( endLength / 2 ).floor();

    if(endLength > 60){
      halfLength = ( endLength / 10 ).floor();
    }

    newSource = source.replaceRange(halfLength, endLength - lastLength, '...');

    return newSource;
  }

  static LatLng convertLatLng(Map location){
    return LatLng(
      location['latitude'].toDouble(),
      location['longitude'].toDouble()
    );
  }

  static Future<void> launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  static String priceFormat(double number,{int range = 1}){
    return number.toStringAsFixed(range);
  }

  static double convertDouble(dynamic number){
    if(number.runtimeType == int){
      return double.parse(number.toString());
    }

    return number;
  } 
}