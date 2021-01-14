import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:supernodeapp/common/repositories/shared/clients/client.dart';
import 'package:supernodeapp/common/repositories/shared/clients/shared_client.dart';
import 'package:supernodeapp/common/repositories/shared/dao/supernode.dart';

import 'interceptors/error_interceptor.dart';
import 'interceptors/headers_interceptor.dart';

class SupernodeHttpClient extends SharedHttpClient implements HttpClient {
  final Supernode Function() getSupernode;

  SupernodeHttpClient({
    @required SupernodeHeadersInterceptor headersInterceptor,
    @required SupernodeErrorInterceptor errorInterceptor,
    this.getSupernode,
    Dio dio,
  }) : super(dio: dio) {
    this.dio.interceptors.add(headersInterceptor);
    this.dio.interceptors.add(errorInterceptor);
  }

  @override
  RequestOptions getOptions() {
    final supernode = getSupernode();
    if (supernode == null) {
      throw Exception('Supernode is unknown');
    }
    return RequestOptions(
      baseUrl: getSupernode().url,
    );
  }
}
