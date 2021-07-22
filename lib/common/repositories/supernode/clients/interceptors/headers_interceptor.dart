import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:supernodeapp/common/repositories/shared/dao/dao.dart';
import 'package:supernodeapp/log.dart';

import 'dispatch_exception.dart';

class SupernodeHeadersInterceptor extends InterceptorsWrapper {
  final String Function() getToken;
  final DateTime Function() getExpiration;
  final Future<String> Function(Dio dio) onTokenRefresh;
  final void Function() onLogOut;

  final Dio dio;

  SupernodeHeadersInterceptor({
    this.getToken,
    this.getExpiration,
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
    if (token != null) options.headers['Grpc-Metadata-Authorization'] = 'Bearer ' + token;
  }

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final json = jsonDecodeOrNull(options.data?.toString());

    DateTime expiredTime = getExpiration();
    bool isExpired = expiredTime == null || 
      expiredTime.isBefore(DateTime.now());

    String token = getToken();

    if (isExpired) {
      token = await onTokenRefresh(Dio());
    }

    setHeaders(
      options,
      otp: json == null ? null : json['otp_code'],
      token: token,
    );
    handler.next(options);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    final response = err.response;

    if (response != null &&
        response.toString().contains(new RegExp(r'jwt|authentication')) &&
        !response.toString().contains("OTP")) {
      dio.interceptors.requestLock.lock();
      dio.interceptors.responseLock.lock();

      try {
        // we use new Dio client because current client is locked.
        final refreshTokenDio = Dio();
        final token = await onTokenRefresh(refreshTokenDio);
        if (token == null) throw Exception('Token can\'t be refreshed');
        setHeaders(response.requestOptions, token: token);
        final res = await dio.request<dynamic>(
          response.requestOptions.path,
          cancelToken: response.requestOptions.cancelToken,
          data: response.requestOptions.data,
          onReceiveProgress: response.requestOptions.onReceiveProgress,
          onSendProgress: response.requestOptions.onSendProgress,
          queryParameters: response.requestOptions.queryParameters,
          options: Options(
            headers: response.requestOptions.headers,
            contentType: response.requestOptions.contentType,
            extra: response.requestOptions.extra,
            method: response.requestOptions.method,
          ),
        );
        handler.resolve(res);
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
        return handler.next(err);
      } finally {
        dio.interceptors.requestLock.unlock();
        dio.interceptors.responseLock.unlock();
      }
    } else {
      handler.next(err);
    }
  }
}
