import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:supernodeapp/common/repositories/shared/dao/dao.dart';
import 'package:supernodeapp/common/repositories/supernode/clients/exceptions/un_authorized_exception.dart';
import 'package:supernodeapp/common/repositories/supernode/clients/exceptions/un_handle_exception.dart';

class SupernodeErrorInterceptor extends InterceptorsWrapper {
  final String Function() getToken;
  final Future<String> Function(Dio dio) onTokenRefresh;
  final void Function() onLogOut;

  final Dio dio;

  SupernodeErrorInterceptor({
    this.getToken,
    this.onTokenRefresh,
    this.onLogOut,
    this.dio,
  });

  jsonDecodeOrNull(String s) {
    try {
      return jsonDecode(s);
    } catch (e) {
      return null;
    }
  }

  void setHeaders(RequestOptions options, {String otp, String token}) {
    if (otp != null) options.headers['Grpc-Metadata-X-OTP'] = otp;
    {
      if (token != null) options.headers['Grpc-Metadata-Authorization'] = token;
    }
  }

  @override
  onError(DioError err) async {
    final Response response = err.response;
    DaoResponse data = DaoResponse.fromJson(response.data);
  
    return DioError(error: _transferException(data));

    // final data = response.data;
    // RETHINK.TODO
    // String userId = settingsData?.userId ?? '';
    // String userName = settingsData?.username ?? '';

    // if (userName == null || userName.isEmpty) {
    //   if (_options.path == '/api/internal/login' && _options.data != null) {
    //     userName = JsonDecoder().convert(_options.data)['username'];
    //   }
    // }

    // CrashesDao().upload(
    //   data ??
    //       {
    //         'code': err.response?.statusCode ?? '500',
    //         'message': err.message,
    //       },
    //   userId: '$userName-$userId',
    //   options: _options,
    // );

    // return err;
  }
}

Exception _transferException(DaoResponse data){
  switch(data.code){
    case 16:
      return UnAuthorizedException(message: data.message);
    default:
      return UnHandleException(message: data.message ?? 'UnHandleException');
  }
}
