import 'dart:isolate';

import 'package:supernodeapp/common/daos/app_dao.dart';
import 'package:supernodeapp/global_store/store.dart';
import 'package:supernodeapp/page/settings_page/state.dart';

class IsolateDao {
  static String token = '';
  static Map isolate = {};
  static Future<dynamic> receive({String url = '',Map data}) async{
    List _params = [];

    final _response = new ReceivePort();

    SettingsState settingsData = GlobalStore.store.getState().settings;
    token = settingsData.token;

    isolate['$url'] = await Isolate.spawn(request,_response.sendPort);

    final _sendPort = await _response.first as SendPort;
    final _answer = new ReceivePort();

    _params.addAll([token,url,data,_answer.sendPort]);
    _sendPort.send(_params);

    return _answer.first;
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
        _send.send(_res ?? {});
      }catch(e){
        _send.send(e);
      }

    });
  }
}