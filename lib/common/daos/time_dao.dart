class TimeDao {
  static Map<String, int> months = {'January': 1,'February': 2,'March': 3,'April': 4,'May': 5,'June': 6,'July': 7,'August': 8,'September': 9,'October': 10,'November': 11,'December': 12};

  static bool isIn5Min(String value){
    if(value == null || value.isEmpty) return false;

    var compareTime = DateTime.parse(value);

    var resTime = (DateTime.now()).subtract(new Duration(minutes: 5));

    return resTime.isBefore(compareTime);
  }

  static bool isInRange(String value,String start,String end){
    if(value.contains('+0000')){
      value = getDatetime(value,type: 'date');
    }

    var compareTime = DateTime.parse(value);
    var startTime = DateTime.parse(start);
    var endTime = DateTime.parse(end);

    if(compareTime.isBefore(startTime)) return false;
    if(compareTime.isAfter(endTime)) return false;

    return true;
  }

  static String getCurrentDatetime(){
    var now = new DateTime.now();

    String currentTime = "${now.year.toString()}-${now.month.toString().padLeft(2,'0')}-${now.day.toString().padLeft(2,'0')} ${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}";
    
    return currentTime;
  }

  static String getDatetime(dynamic timeTemp,{String type = 'datetime'}){
    if(timeTemp == null) return '';

    dynamic time = timeTemp;
    if(timeTemp is int){
      time = DateTime(timeTemp);
    }else if(timeTemp is String){
      if(timeTemp.isEmpty) return '';

      if(timeTemp.contains('+0000')){
        var timeArr = timeTemp.split(' ');
        return '${timeArr[0]}';
      }

      if(timeTemp.contains('--')){
        return timeTemp;
      }

      time = DateTime.parse(timeTemp);
    }

    String convertTime = '';

    if(type == 'date'){
      convertTime = "${time.year.toString()}-${time.month.toString().padLeft(2,'0')}-${time.day.toString().padLeft(2,'0')}";
    }else if(type == 'md'){
      convertTime = "${time.month.toString().padLeft(2,'0')}-${time.day.toString().padLeft(2,'0')}";
    }else if(type == 'month'){
      convertTime = "${time.month.toString().padLeft(2,'0')}";
    }else if(type == 'day'){
      convertTime = "${time.day.toString().padLeft(2,'0')}";
    }else if(type == 'time'){
      convertTime = "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}:${time.second.toString().padLeft(2, '0')}";
    }else{
      convertTime = "${time.year.toString()}-${time.month.toString().padLeft(2,'0')}-${time.day.toString().padLeft(2,'0')} ${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}:${time.second.toString().padLeft(2, '0')}";
    }
    
    return convertTime;
  }

  static int getCurrentTimeStamp(){
    var now = new DateTime.now();
    return now.millisecondsSinceEpoch;
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

  static String comparedDateTime(context,String oldTime){
    var now = new DateTime.now();
    var beforeTime = DateTime.parse(oldTime);

    var diff = now.difference(beforeTime);

    String getHM(str){
      var datetimeArr = str.split(' ');
      var timeArr = datetimeArr[1].split(':');
      return '${timeArr[0]}:${timeArr[1]}';
    }

    String getMDHM(str){
      var datetimeArr = str.split(' ');
      var dateArr = datetimeArr[0].split('-');
      var timeArr = datetimeArr[1].split(':');
      return '${dateArr[1]}-${dateArr[2]} ${timeArr[0]}:${timeArr[1]}';
    }

    String getYMDHM(str){
      var datetimeArr = str.split(' ');
      var timeArr = datetimeArr[1].split(':');
      return '${datetimeArr[0]} ${timeArr[0]}:${timeArr[1]}';
    }

    if(diff.inHours < 24){
      return getHM(oldTime);
    }else if(diff.inDays > 0 && diff.inDays <= 1){
      return '';
      // return '${AppStrings.of(context).yesterday()} ' + getHM(oldTime);
    }else if(diff.inDays <= 7){
      return getMDHM(oldTime);
    }else{
      return getYMDHM(oldTime);
    }

  }
}