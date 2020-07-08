import 'dart:developer';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/tip.dart';
import 'package:supernodeapp/common/daos/crashes_dao.dart';
import 'package:supernodeapp/common/daos/dao.dart';
import 'package:supernodeapp/configs/config.dart';
import 'package:supernodeapp/common/utils/storage_manager_native.dart';
import 'package:supernodeapp/global_store/store.dart';
import 'package:supernodeapp/page/home_page/action.dart';
import 'package:supernodeapp/page/settings_page/state.dart';


class TokenInterceptors extends InterceptorsWrapper {
  String _token;
  RequestOptions _options;
  @override
  onRequest(RequestOptions options) async {
    _options = options;
    var json = jsonDecode(options.data.toString());

    String otpCode = '';
    if(json != null){
      if(json['otp_code'] != null){
        otpCode = json['otp_code'];
      }
    }
    //授权码
    if (_token == null) {
      var authorizationCode = await getAuthorization();
      if (authorizationCode != Null) {
        _token = authorizationCode;
        options.headers["Grpc-Metadata-Authorization"] = _token;
      }
      if(otpCode != ''){
        options.headers["Grpc-Metadata-X-OTP"] = otpCode;
      }
    }
    else{
        options.headers["Grpc-Metadata-Authorization"] = '$_token';
        if(otpCode != ''){
          options.headers["Grpc-Metadata-X-OTP"] = otpCode;
        }
    }
    return options;
  }

  @override
  onResponse(Response response) async {
    try {
      var responseJson = response.data;
      if (response.statusCode == 200 && responseJson[Config.TOKEN_KEY] != null) {
        _token = responseJson[Config.TOKEN_KEY];
        StorageManager.sharedPreferences.setString(Config.TOKEN_KEY, _token);
      }
    } catch (e) {
      print(e);
    }
    return response;
  }

  @override
  onError(DioError err) async {
    var errRes = err.response;

    if(errRes != null && errRes.toString().contains(new RegExp(r'jwt'))){
      /// when token is expired, it needs to start to login.
      Dao.ctx.dispatch(HomeActionCreator.onReLogin());
    }else{
      tip(Dao.ctx.context, FlutterI18n.translate(Dao.ctx.context,'error_tip'));
    }

    SettingsState settingsData = GlobalStore.store.getState().settings;
    CrashesDao().upload(errRes.data,userId: settingsData?.userId ?? '',options: _options);

    return err;
  }

  ///清除授权
  clearAuthorization() async {
    this._token = null;
    await StorageManager.sharedPreferences.remove(Config.TOKEN_KEY);
  }

  ///获取授权token
  getAuthorization() async {
    String token = StorageManager.sharedPreferences.getString(Config.TOKEN_KEY);
    log('${Config.TOKEN_KEY}=$token');
    if (token == null) {
      return Null;
    } else {
      return "$token";
    }
  }
}
