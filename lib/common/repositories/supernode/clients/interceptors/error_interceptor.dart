import 'dart:convert';

import 'package:dio/dio.dart';

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
      if (token != null) options.headers['Grpc-Metadata-Authorization'] = 'Bearer ' + token;
    }
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    handler.next(err);

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
