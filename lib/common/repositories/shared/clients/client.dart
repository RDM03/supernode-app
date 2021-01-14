import 'package:flutter/foundation.dart';

abstract class HttpClient {
  Future<dynamic> post({
    @required String url,
    dynamic data,
    Map<String, dynamic> headers,
    bool encodeJson = true,
  });

  Future<dynamic> get({@required String url, Map data});
  Future<dynamic> put({@required String url, dynamic data});
  Future<dynamic> delete({@required String url});
}

class HttpException implements Exception {
  final String message;
  final int code;

  HttpException(this.message, this.code);

  @override
  String toString() {
    return '[$code] $message';
  }
}
