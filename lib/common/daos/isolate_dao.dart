import 'dart:isolate';

import 'package:dio/dio.dart';
import 'package:supernodeapp/common/daos/app_dao.dart';
import 'package:supernodeapp/common/utils/utils.dart';
import 'package:supernodeapp/configs/config.dart';

class IsolateDao {
  static String token = '';
  static Future<dynamic> receive({String url = '',Map data}) async{
    
    if(token.isEmpty){
      token = StorageManager?.sharedPreferences?.getString(Config.TOKEN_KEY);
    }

    final response = new ReceivePort();
    await Isolate.spawn(request,response.sendPort);
    final sendPort = await response.first as SendPort;
    final answer = new ReceivePort();

    List params = [];

    params.addAll([token,url,data,answer.sendPort]);
    sendPort.send(params);
  
    return answer.first;
  }
  
  static void request(SendPort initialReplyTo) async{
    final _port = new ReceivePort();
    initialReplyTo.send(_port.sendPort);
    _port.listen((message) async{

      String _token = message[0] as String;
      String _url = message[1] as String;
      Map _data = message[2] as Map;
      SendPort _send;

      int _total = message.length;
      _send = message[_total - 1] as SendPort;

      try{
        var _res = await DaoSingleton.get(token: _token,url: _url,data: _data);
        _send.send(_res);
      }catch(e){
        _send.send(e);
      }

    });
  }
}