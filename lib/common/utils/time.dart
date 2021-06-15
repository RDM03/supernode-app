class TimeUtil {
  static Map<String, int> months = {
    'January': 1,
    'February': 2,
    'March': 3,
    'April': 4,
    'May': 5,
    'June': 6,
    'July': 7,
    'August': 8,
    'September': 9,
    'October': 10,
    'November': 11,
    'December': 12
  };

  static Map<int, String> monthsAbb = {
    1: 'Jan',
    2: 'Feb',
    3: 'Mar',
    4: 'Apr',
    5: 'May',
    6: 'Jun',
    7: 'Jul',
    8: 'Aug',
    9: 'Sep',
    10: 'Oct',
    11: 'Nov',
    12: 'Dec',
  };

  static Map<int, String> week = {
    1: 'Mon',
    2: 'Tue',
    3: 'Wed',
    4: 'Thu',
    5: 'Fri',
    6: 'Sat',
    7: 'Sun',
  };

  static final Map<int, String> monthsReversed = <int, String>{
    for (final m in months.entries) m.value: m.key
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

  static String getMD(DateTime date) {
    return '${monthsReversed[date.month]} ${date.day}';
  }

  static String getMDAbb(DateTime date) {
    return '${monthsAbb[date.month]} ${date.day}';
  }

  static String getMYAbb(DateTime date,{bool withApostrophe = false}) {
    return '${monthsAbb[date.month]}${withApostrophe == true ? "\'" : " "}${date.year.toString().substring(2)}';
  }

  static String getMDY(DateTime date) {
    return '${monthsReversed[date.month]} ${date.day} ${date.year}';
  }

  static int getCurrentTimeStamp() {
    var now = new DateTime.now();
    return now.millisecondsSinceEpoch;
  }

  static String getYM(DateTime date) {
    return '${date.year}${date.month.toString().padLeft(2, '0')}';
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
