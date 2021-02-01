import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:supernodeapp/common/repositories/shared/clients/client.dart';

class SharedHttpClient implements HttpClient {
  final Dio dio;

  SharedHttpClient({Dio dio}) : dio = dio ?? Dio() {
    this.dio.interceptors.add(PrettyDioLogger());
  }

  RequestOptions getOptions([Map<String, dynamic> headers]) {
    return RequestOptions(
      headers: headers,
    );
  }

  void _handleDioError(DioError e, StackTrace innerStack) {
    final message =
        e.response != null ? e.response.data['message'].toString() : e.message;
    final code =
        e.response != null ? int.tryParse(e.response.data['code']) : -1;
    throw HttpException(message, code, innerStack);
  }

  @override
  Future get({@required String url, Map data}) async {
    try {
      final res = await dio.get(
        url,
        queryParameters:
            data != null ? new Map<String, dynamic>.from(data) : null,
        options: getOptions(),
      );
      return res.data;
    } on DioError catch (e, stack) {
      _handleDioError(e, stack);
    }
  }

  @override
  Future post({
    @required String url,
    dynamic data,
    Map<String, dynamic> headers,
    bool encodeJson = true,
  }) async {
    try {
      final res = await dio.post(
        url,
        data: data,
        options: getOptions(headers),
      );
      return res.data;
    } on DioError catch (e, stack) {
      _handleDioError(e, stack);
    }
  }

  @override
  Future put({@required String url, data}) async {
    try {
      final res = await dio.put(url, data: data, options: getOptions());
      return res.data;
    } on DioError catch (e, stack) {
      _handleDioError(e, stack);
    }
  }

  @override
  Future delete({@required String url}) async {
    try {
      final res = await dio.delete(url, options: getOptions());
      return res.data;
    } on DioError catch (e, stack) {
      _handleDioError(e, stack);
    }
  }

  void dispose() {
    dio.close();
  }
}
