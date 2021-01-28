import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:supernodeapp/log.dart';

class SupernodeHeadersInterceptor extends InterceptorsWrapper {
  final String Function() getToken;
  final Future<String> Function(Dio dio) onTokenRefresh;
  final void Function() onLogOut;

  final Dio dio;

  SupernodeHeadersInterceptor({
    this.getToken,
    this.onTokenRefresh,
    this.onLogOut,
    this.dio, // we need to register dio to support requests lock
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
    if (token != null) options.headers['Grpc-Metadata-Authorization'] = token;
  }

  @override
  onRequest(RequestOptions options) async {
    final json = jsonDecodeOrNull(options.data?.toString());
    setHeaders(
      options,
      otp: json == null ? null : json['otp_code'],
      token: getToken(),
    );
    return options;
  }

  @override
  onError(DioError err) async {
    final response = err.response;

    if (response != null &&
        response.toString().contains(new RegExp(r'jwt|authentication'))) {
      dio.interceptors.requestLock.lock();
      dio.interceptors.responseLock.lock();

      try {
        // we use new Dio client because current client is locked.
        final refreshTokenDio = Dio();
        final token = await onTokenRefresh(refreshTokenDio);
        final request = err.request;
        setHeaders(request, token: token);
        return request;
      } on Exception catch (e, stack) {
        if (e is DioError &&
            e.response?.statusCode != null &&
            e.response.statusCode == 401) {
          logger.w(
              'Error 401 received while refreshing token. Logging out.', e);
          onLogOut();
        } else {
          logger.e('Error while refreshing token.', e, stack);
        }
        return err;
      } finally {
        dio.interceptors.requestLock.unlock();
        dio.interceptors.responseLock.unlock();
      }
    }
  }
}
