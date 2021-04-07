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
}
