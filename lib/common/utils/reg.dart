import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

class Reg{
  static String isEmpty(String value){
    if(value.trim().isEmpty){
      return 'reg_required';
    }

    return null;
  }

  static bool isAddress(String value) {
    var reg = RegExp(r'^[A-z\d]{47,48}$');
    return reg.hasMatch(value);
  }

  static String isEmail(String value){
    RegExp emailRule = new RegExp(r'^[A-Za-z0-9\u4e00-\u9fa5_\.]+@[a-zA-Z0-9_]+(\.[a-zA-Z0-9_-]+)+$');

    if(!emailRule.hasMatch(value.trim())){
      return 'reg_invalid_email';
    }

    return null;
  }

  static String isBigger(String value,int total){
    if(value.trim().length < total){
      return 'reg_morethan';
    }

    return null;
  }

  static String isEqual(String value1,String value2,String ext){
    if(value1 != value2){
      return 'reg_password_not_same';
    }

    return null;
  }

  static String isNumber(String value){
    bool isNaN = double.parse(value).isNaN;
    //RegExp numberRule = new RegExp(r'^[0-9]\d*$');

    if(isNaN){//!numberRule.hasMatch(value.trim())
      return 'reg_not_number';
    }

    return null;
  }

  static String onValidEmail(BuildContext context,String value){
    String res = isEmpty(value);
    if(res != null) return FlutterI18n.translate(context, res); 

    res = isEmail(value);
    if(res != null){
      return FlutterI18n.translate(context,res);
    }

    return null;
  }

  static String onValidPassword(BuildContext context,String value){
    String res = Reg.isEmpty(value);
    if(res != null) return FlutterI18n.translate(context, res); 

    String  pattern = r'^(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!#$%&*+,-./<=>?@[\]^_`|~]).{8,}$';

    RegExp passwordRule = new RegExp(pattern);

    if(!passwordRule.hasMatch(value.trim())){
      return FlutterI18n.translate(context,'reg_invalid_password');
    }

    return null;
  }

  static String onValidNumber(BuildContext context,String value,{bool isShowError = true}){
    String res = Reg.isEmpty(value);
    if(res != null) return FlutterI18n.translate(context, isShowError ? res : ''); 

    res = Reg.isNumber(value); 

    if(res != null){
      return FlutterI18n.translate(context,isShowError ? res : '');
    }

    return null;
  }

  static String onNotEmpty(BuildContext context,String value,{bool isShowError = true}){
    String res = Reg.isEmpty(value);
    if(res != null) return FlutterI18n.translate(context, isShowError ? res : ''); 
    
    return null;
  }

  static String onValidAmount(BuildContext context,String value,{bool isShowError = true}){
    String res = Reg.isEmpty(value);
    if(res != null) return FlutterI18n.translate(context, res); 

    RegExp numberRule = new RegExp(r'^[1-9]\d*$');

    if(!numberRule.hasMatch(value.trim())){
      return FlutterI18n.translate(context, 'reg_amount');
    }

    return null;
  }
}