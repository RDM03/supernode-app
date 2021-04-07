import 'package:supernodeapp/common/repositories/shared/clients/client.dart';
import '../../../shared/dao/dao.dart';

class DemoDao implements HttpDao {
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
  Future<String> delete({String url}) {
    throw UnimplementedError("Direct delete unavailable in demo");
  }

  @override
  HttpClient get client => throw UnimplementedError();
}
