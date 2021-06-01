import 'dart:math';

import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:url_launcher/url_launcher.dart';

class Tools {
  static bool isSameDay(DateTime time1, DateTime time2) {
    return time1.year == time2.year &&
        time1.month == time2.month &&
        time1.day == time2.day;
  }

  static bool isSameMonth(DateTime time1, DateTime time2) {
    return time1.year == time2.year && time1.month == time2.month;
  }

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

  static LatLng convertLatLng(Map location) {
    if (location['latitude'] is String) {
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
    if (number == null || number == 0) {
      return '0.0';
    }
    String newNumber = number?.toStringAsFixed((range + 1)) ?? '0.0';
    return newNumber.substring(0, newNumber.lastIndexOf('.') + range + 1);
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

  static String dateMonthYearFormat(DateTime date) {
    if (date == null) return '?';
    final month = date.month.toString().padLeft(2, '0');
    return '$month/${date.year}';
  }

  static String dateMonthDayFormat(DateTime date) {
    if (date == null) return '?';
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    return '$month $day';
  }

  static String dateMonthDayYearFormat(DateTime date) {
    if (date == null) return '?';
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    return '$month $day ${date.year}';
  }

  static String numberRounded(double number) {
    if (number == null) {
      return '0';
    }

    String round(double val, int order, {int afterDot = 0}) {
      final divided = (val / order);
      if (afterDot == 0) return divided.round().toString();
      final wholePart = divided.floor();
      final fractionPart = divided - wholePart;
      final fractionPartRounded =
          (fractionPart * 10 * afterDot).roundToDouble();
      var fractionPartTruncated = fractionPartRounded;
      while (fractionPartTruncated % 10 == 0 && fractionPartTruncated > 0)
        fractionPartTruncated /= 10.0;

      if (fractionPartTruncated == 0) return wholePart.toString();
      return '$wholePart.${fractionPartTruncated.toStringAsFixed(0)}';
    }

    if (number >= 1000000000) {
      return '${round(number, 1000000000, afterDot: 1)}b';
    }
    if (number >= 1000000) {
      return '${round(number, 1000000, afterDot: 1)}m';
    }
    if (number >= 10000) {
      return '${round(number, 1000)}k';
    }
    return number.round().toString();
  }

  /// Function calculated number of decimal places [1-3]
  /// in order to represent double in format: maximum xxx.x, and minimum x.xxx
  static int max3DecimalPlaces(double minedAmount) {
    return min(3, max(1, (3 - (log(minedAmount) / ln10).floor())));
  }
}
