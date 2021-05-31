import 'dart:convert';

import 'package:supernodeapp/common/repositories/shared/clients/client.dart';

class HttpDao {
  final HttpClient client;

  HttpDao(this.client);

  Future<dynamic> post({
    String url,
    dynamic data,
    Map<String, dynamic> headers,
    bool encodeJson = true,
  }) {
    return client.post(
      url: url,
      data:  encodeJson ? JsonEncoder().convert(data) : data,
      headers: headers,
      encodeJson: encodeJson,
    );
  }

  Future<dynamic> get({String url, Map data}) async {
    return client.get(
      url: url,
      data: data,
    );
  }

  Future<dynamic> put({String url, dynamic data}) async {
    return client.put(
      url: url,
      data: data,
    );
  }

  Future<dynamic> delete({String url}) async {
    return client.delete(url: url);
  }

  Future<String> downloadFile({String url}) async {
    return client.downloadFile(url: url);
  }
}


abstract class BaseResponse {
  int code = 0;
  String message;
  dynamic data;

  bool get success;

  BaseResponse({
    this.code, 
    this.message, 
    this.data
  });

  @override
  String toString() {
    return 'HttpResponse {code: $code, message: $message, data: $data}';
  }
}


class DaoResponse extends BaseResponse {
  bool get success => (code == 200);

  DaoResponse.fromJson(Map<String, dynamic> json) {
    code = json["code"];
    message = json["message"];
    data = json["data"];
  }
}