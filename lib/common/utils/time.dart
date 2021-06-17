import 'package:flutter/cupertino.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

class TimeUtil {
  static Map<int, String> months(BuildContext context) => {
    1: FlutterI18n.translate(context, 'january'),
    2: FlutterI18n.translate(context, 'february'),
    3: FlutterI18n.translate(context, 'march'),
    4: FlutterI18n.translate(context, 'april'),
    5: FlutterI18n.translate(context, 'may_full'),
    6: FlutterI18n.translate(context, 'june'),
    7: FlutterI18n.translate(context, 'july'),
    8: FlutterI18n.translate(context, 'august'),
    9: FlutterI18n.translate(context, 'september'),
    10: FlutterI18n.translate(context, 'october'),
    11: FlutterI18n.translate(context, 'november'),
    12: FlutterI18n.translate(context, 'december'),
  };

  static Map<int, String> monthsShort(BuildContext context) => {
    1: FlutterI18n.translate(context, 'jan'),
    2: FlutterI18n.translate(context, 'feb'),
    3: FlutterI18n.translate(context, 'mar'),
    4: FlutterI18n.translate(context, 'apr'),
    5: FlutterI18n.translate(context, 'may_short'),
    6: FlutterI18n.translate(context, 'jun'),
    7: FlutterI18n.translate(context, 'jul'),
    8: FlutterI18n.translate(context, 'aug'),
    9: FlutterI18n.translate(context, 'sep'),
    10: FlutterI18n.translate(context, 'oct'),
    11: FlutterI18n.translate(context, 'nov'),
    12: FlutterI18n.translate(context, 'dec'),
  };

  static Map<int, String> weekDayShort(BuildContext context) => {
    1: FlutterI18n.translate(context, 'mon'),
    2: FlutterI18n.translate(context, 'tue'),
    3: FlutterI18n.translate(context, 'wed'),
    4: FlutterI18n.translate(context, 'thu'),
    5: FlutterI18n.translate(context, 'fri'),
    6: FlutterI18n.translate(context, 'sat'),
    7: FlutterI18n.translate(context, 'sun'),
  };

  static bool isIn5Min(String value) {
    if (value == null || value.isEmpty) return false;

    var compareTime = DateTime.parse(value);

    var resTime = (DateTime.now()).subtract(new Duration(minutes: 5));

    return resTime.isBefore(compareTime);
  }

  static bool isInRange(String value, String start, String end) {
    if (value.contains('+0000')) {
      value = getDatetime(value, type: 'date');
    }

    var compareTime = DateTime.parse(value);
    var startTime = DateTime.parse(start);
    var endTime = DateTime.parse(end);

    if (compareTime.isBefore(startTime)) return false;
    if (compareTime.isAfter(endTime)) return false;

    return true;
  }

  static String getCurrentDatetime() {
    var now = new DateTime.now();

    String currentTime =
        "${now.year.toString()}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')} ${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}";

    return currentTime;
  }

  static String getDatetime(dynamic timeTemp, {String type = 'datetime'}) {
    if (timeTemp == null) return '';

    dynamic time = timeTemp;
    if (timeTemp is int) {
      time = DateTime(timeTemp);
    } else if (timeTemp is String) {
      if (timeTemp.isEmpty) return '';

      if (timeTemp.contains('+0000')) {
        var timeArr = timeTemp.split(' ');
        return '${timeArr[0]}';
      }

      if (timeTemp.contains('--')) {
        return timeTemp;
      }

      time = DateTime.parse(timeTemp);
    }
    time = time.toLocal();

    String convertTime = '';

    if (type == 'date') {
      convertTime =
          "${time.year.toString()}-${time.month.toString().padLeft(2, '0')}-${time.day.toString().padLeft(2, '0')}";
    } else if (type == 'md') {
      convertTime =
          "${time.month.toString().padLeft(2, '0')}-${time.day.toString().padLeft(2, '0')}";
    } else if (type == 'month') {
      convertTime = "${time.month.toString().padLeft(2, '0')}";
    } else if (type == 'day') {
      convertTime = "${time.day.toString().padLeft(2, '0')}";
    } else if (type == 'time') {
      convertTime =
          "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}:${time.second.toString().padLeft(2, '0')}";
    } else {
      convertTime =
          "${time.year.toString()}-${time.month.toString().padLeft(2, '0')}-${time.day.toString().padLeft(2, '0')} ${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}:${time.second.toString().padLeft(2, '0')}";
    }

    return convertTime;
  }

  static String getM(DateTime date) {
    return '${date.month.toString().padLeft(2, '0')}';
  }

  static int getCurrentTimeStamp() {
    var now = new DateTime.now();
    return now.millisecondsSinceEpoch;
  }

  static bool isSameDay(DateTime time1, DateTime time2) {
    return time1.year == time2.year &&
        time1.month == time2.month &&
        time1.day == time2.day;
  }

  static bool isSameMonth(DateTime time1, DateTime time2) {
    return time1.year == time2.year && time1.month == time2.month;
  }

  static String dateMonthFormat(DateTime date) {
    if (date == null) return '?';
    final month = date.month;
    return '$month';
  }

  // static String comparedNow(context,String oldTime){
  //   String language = localeName(context);
  //   String space = '';
  //   if(language == 'en'){
  //     space = ' ';
  //   }

  //   var now = new DateTime.now();
  //   var beforeTime = DateTime.parse(oldTime);

  //   var diff = now.difference(beforeTime);

  //   if(diff.inSeconds == 0){
  //     return AppStrings.of(context).just();
  //   }else if(diff.inSeconds <= 60){
  //     return '${diff.inSeconds}$space${AppStrings.of(context).second()}$space${AppStrings.of(context).ago()}';
  //   }else if(diff.inMinutes <= 60){
  //     return '${diff.inMinutes}$space${AppStrings.of(context).minute()}$space${AppStrings.of(context).ago()}';
  //   }else if(diff.inHours <= 24){
  //     return '${diff.inHours}$space${AppStrings.of(context).hour()}$space${AppStrings.of(context).ago()}';
  //   }else if(diff.inDays <= 30){
  //     return '${diff.inDays}$space${AppStrings.of(context).day()}$space${AppStrings.of(context).ago()}';
  //   }else if(diff.inDays > 30 && diff.inDays <= 365){
  //     var months = (diff.inDays / 30).round();
  //     return '$months$space${AppStrings.of(context).month()}$space${AppStrings.of(context).ago()}';
  //   }else{
  //     var years = (diff.inDays / 365).round();
  //     return '$years$space${AppStrings.of(context).year()}$space${AppStrings.of(context).ago()}';
  //   }

  // }

  static String comparedDateTime(context, String oldTime) {
    var now = new DateTime.now();
    var beforeTime = DateTime.parse(oldTime);

    var diff = now.difference(beforeTime);

    String getHM(str) {
      var datetimeArr = str.split(' ');
      var timeArr = datetimeArr[1].split(':');
      return '${timeArr[0]}:${timeArr[1]}';
    }

    String getMDHM(str) {
      var datetimeArr = str.split(' ');
      var dateArr = datetimeArr[0].split('-');
      var timeArr = datetimeArr[1].split(':');
      return '${dateArr[1]}-${dateArr[2]} ${timeArr[0]}:${timeArr[1]}';
    }

    String getYMDHM(str) {
      var datetimeArr = str.split(' ');
      var timeArr = datetimeArr[1].split(':');
      return '${datetimeArr[0]} ${timeArr[0]}:${timeArr[1]}';
    }

    if (diff.inHours < 24) {
      return getHM(oldTime);
    } else if (diff.inDays > 0 && diff.inDays <= 1) {
      return null;
    } else if (diff.inDays <= 7) {
      return getMDHM(oldTime);
    } else {
      return getYMDHM(oldTime);
    }
  }
}
