import 'package:dio/dio.dart';
import '../dao.dart';

class DemoDao implements Dao {
  @override
  bool inProduction;

  @override
  bool isMock;

  @override
  Response response;

  @override
  Future get({String url, Map data}) {
    throw UnimplementedError("Direct GET unavailable in demo");
  }

  @override
  Future post({
    String url,
    data,
    Map<String, dynamic> headers,
    bool encodeJson = true,
  }) {
    throw UnimplementedError("Direct POST unavailable in demo");
  }

  @override
  Future put({String url, data}) {
    throw UnimplementedError("Direct PUT unavailable in demo");
  }

  @override
  Future getMethod({String url, Map data}) {
    throw UnimplementedError("Direct getMethod unavailable in demo");
  }
}
