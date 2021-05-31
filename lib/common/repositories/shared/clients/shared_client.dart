import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:supernodeapp/common/repositories/shared/clients/client.dart';
import 'package:supernodeapp/common/repositories/supernode/clients/exceptions/un_authorized_exception.dart';
import 'package:ext_storage/ext_storage.dart';

class SharedHttpClient implements HttpClient {
  final Dio dio;

  SharedHttpClient({Dio dio}) : dio = dio ?? Dio() {
    this.dio.interceptors.add(PrettyDioLogger());
  }

  String get baseUrl => null;

  Options getOptions([Map<String, dynamic> headers]) {
    return Options(
      headers: headers,
    );
  }

  void _handleDioError(DioError e, StackTrace innerStack) {
    if (e.error is UnAuthorizedException) {
      throw e.error;
    }

    final message =
        e.response != null ? e.response.data['message'].toString() : e.message;
    final code = e.response != null
        ? (e.response.data['code'] is int
            ? e.response.data['code']
            : int.tryParse(e.response.data['code']))
        : -1;
    throw HttpException(message, code, innerStack);
  }

  String _fmtUrl(String url) {
    if (baseUrl == null) return url;
    if (baseUrl.endsWith('/') || url.startsWith('/')) {
      return baseUrl + url;
    }
    return baseUrl + '/' + url;
  }

  @override
  Future get({@required String url, Map data}) async {
    try {
      final res = await dio.get(
        _fmtUrl(url),
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
        _fmtUrl(url),
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
      final res =
          await dio.put(_fmtUrl(url), data: data, options: getOptions());
      return res.data;
    } on DioError catch (e, stack) {
      _handleDioError(e, stack);
    }
  }

  @override
  Future delete({@required String url}) async {
    try {
      final res = await dio.delete(_fmtUrl(url), options: getOptions());
      return res.data;
    } on DioError catch (e, stack) {
      _handleDioError(e, stack);
    }
  }

  @override
  Future<String> downloadFile({String url}) async {
    final List<String> urlParts = url.split('/');
    final String fileName = (urlParts.length > 0) ? urlParts[urlParts.length - 1] : "file_name";
    final String filePath = (Platform.isAndroid)
      ? await ExtStorage.getExternalStoragePublicDirectory(ExtStorage.DIRECTORY_DOWNLOADS)
      : (await getApplicationDocumentsDirectory()).path;

    String fullPath = "$filePath/$fileName";
    await dio.download(
        _fmtUrl(url),
        fullPath,
        onReceiveProgress: (receivedBytes, totalBytes) {
          String progress = ((receivedBytes / totalBytes) * 100).toStringAsFixed(0) + "%";
          //TODO progress mLog('test', 'received $receivedBytes / total $totalBytes = $progress');
        });

    return fullPath;
  }

  void dispose() {
    dio.close();
  }
}
