import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:supernodeapp/configs/config.dart';

class LogsInterceptors extends InterceptorsWrapper {
  static List<Map> sHttpResponses = new List<Map>();
  static List<String> sResponsesHttpUrl = new List<String>();

  static List<Map<String, dynamic>> sHttpRequest =
      new List<Map<String, dynamic>>();
  static List<String> sRequestHttpUrl = new List<String>();

  static List<Map<String, dynamic>> sHttpError =
      new List<Map<String, dynamic>>();
  static List<String> sHttpErrorUrl = new List<String>();

  @override
  onRequest(RequestOptions options) async {
    if (Config.DEBUG) {
      print("request url：${options.path}");
      print('headers: ' + options.headers.toString());
      print('method: '+options.method);
      if (options.data != null) {
        print('params: ' + options.data.toString());
      }
      if(options.queryParameters!=null){
        print('params: ' + options.queryParameters.toString());
      }
    }

    try {
      addLogic(sRequestHttpUrl, options.path ?? "");
      var data = options.data ?? Map<String, dynamic>();
      var map = {
        "header:": options.headers,
      };
      if (options.method == "POST") {
        map["data"] = data;
      }
      addLogic(sHttpRequest, map);
    } catch (e) {
      print(e);
    }
    return options;
  }

  @override
  onResponse(Response response) async {
    if (Config.DEBUG) {
      if (response != null) {
        print('result: ' + response.toString());
      }
    }

    if (response.data is Map || response.data is List) {
      print(1);
      try {
        var data = Map<String, dynamic>();
        data["data"] = response.data;
        addLogic(sResponsesHttpUrl, response?.request?.uri?.toString() ?? "");
        addLogic(sHttpResponses, data);
      } catch (e) {
        print(e);
      }
    } else if (response.data is String) {
      print(2);
      try {
        var data = Map<String, dynamic>();

        data["data"] = response.data;
        addLogic(sResponsesHttpUrl, response?.request?.uri.toString() ?? "");
        addLogic(sHttpResponses, data);
      } catch (e) {
        print(e);
      }
    } else if (response.data != null) {
      print(3);
      try {
        String data = response.data.toJson();
        print("chocho data"+ data);
        addLogic(sResponsesHttpUrl, response?.request?.uri.toString() ?? "");
        addLogic(sHttpResponses, json.decode(data));
      } catch (e) {
        print(e);
      }
    }
    print(response);
    return response; // continue
  }

  @override
  onError(DioError err) async {
    if (Config.DEBUG) {
      print('error: ' + err.toString());
      print('error info: ' + err.response?.toString() ?? "");
    }

    try {
      addLogic(sHttpErrorUrl, err.request.path ?? "null");
      var errors = Map<String, dynamic>();
      errors["error"] = err.message;
      addLogic(sHttpError, errors);
    } catch (e) {
      print(e);
    }
    return err; // continue;
  }

  static addLogic(List list, data) {
    if (list.length > 20) {
      list.removeAt(0);
    }
    list.add(data);
  }
}
