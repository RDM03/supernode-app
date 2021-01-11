import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:supernodeapp/common/daos/interceptors/log_interceptor.dart';
import 'package:supernodeapp/common/daos/interceptors/token_interceptor.dart';
import 'package:supernodeapp/common/daos/isolate_dao.dart';
import 'package:supernodeapp/page/home_page/action.dart';

class DaoException implements Exception {
  final String message;
  final int code;

  DaoException(this.message, this.code);

  @override
  String toString() {
    return '[$code] $message';
  }
}

class Dao {
  static String baseUrl = '';
  static String token = '';
  static var ctx;

  bool inProduction = const bool.fromEnvironment('dart.vm.product');
  bool isMock = false;

  Response response;
  static Dio dio = new Dio();

  Dao() {
    dio.options.baseUrl = baseUrl; //inProduction ? baseUrl : Sys.buildBaseUrl;
    dio.interceptors.add(TokenInterceptors());
    dio.interceptors.add(LogsInterceptors());
  }

  Future<dynamic> post({
    String url,
    dynamic data,
    Map<String, dynamic> headers,
    bool encodeJson = true,
  }) async {
    try {
      Response response = await dio.post(
        url,
        data: encodeJson ? JsonEncoder().convert(data) : data,
        options: headers != null ? Options(headers: headers) : null,
      );

      return response.data;
    } on DioError catch (e) {
      final message =
          e.response != null ? e.response.data['message'] : e.message;
      final code = e.response != null ? e.response.data['code'] : -1;
      throw DaoException(message, code);
    }
  }

  Future<dynamic> get({String url, Map data}) async {
    try {
      if (!url.contains('http')) {
        url = dio.options.baseUrl + url;
      }
      var res;
      //if isolate had this request, stop to address this process.
      if (!IsolateDao.isolate.containsKey('$url')) {
        res = await IsolateDao.receive(url: url, data: data);

        if (IsolateDao.isolate.containsKey('$url')) {
          IsolateDao.isolate['$url'].kill();
          IsolateDao.isolate.remove('$url');
        }

        return res;
      }
      return {};
    } catch (e) {
      return getMethod(url: url, data: data);
    }
  }

  Future<dynamic> getMethod({String url, Map data}) async {
    try {
      Response response = await dio.get(
        url,
        queryParameters:
            data != null ? new Map<String, dynamic>.from(data) : null,
      );

      if (response.statusCode == 200) {
        return response.data;
      }
    } on DioError catch (e) {
      final message =
          e.response != null ? e.response.data['message'] : e.message;
      final code = e.response != null ? e.response.data['code'] : -1;
      throw DaoException(message, code);
    }
  }

  Future<dynamic> put({String url, dynamic data}) async {
    try {
      Response response = await dio.put(
        url,
        data: JsonEncoder().convert(data),
      );

      if (response.statusCode == 200) {
        return response.data;
      }
    } on DioError catch (e) {
      final message =
          e.response != null ? e.response.data['message'] : e.message;
      final code = e.response != null ? e.response.data['code'] : -1;
      throw DaoException(message, code);
    }
  }

  Future<dynamic> delete({String url}) async {
    try {
      Response response = await dio.delete(url);

      if (response.statusCode == 200) {
        return response.data;
      }
    } on DioError catch (e) {
      final message =
          e.response != null ? e.response.data['message'] : e.message;
      final code = e.response != null ? e.response.data['code'] : -1;
      throw DaoException(message, code);
    }
  }
}

class DaoSingleton {
  static Future<dynamic> get({String token, String url, Map data}) async {
    Dio _dio;
    try {
      _dio = Dio(BaseOptions(headers: {"Grpc-Metadata-Authorization": token}));

      Response response = await _dio.get(
        url,
        queryParameters:
            data != null ? new Map<String, dynamic>.from(data) : null,
      );
      if (response.statusCode == 200) {
        return response.data;
      }
    } on DioError catch (err) {
      print(err);
    }
  }

  // singleton
  factory DaoSingleton() => _getInstance();

  static DaoSingleton get instance => _getInstance();
  static DaoSingleton _instance;

  DaoSingleton._internal();

  static DaoSingleton _getInstance() {
    if (_instance == null) {
      _instance = new DaoSingleton._internal();
    }
    return _instance;
  }
}
