import 'package:fish_redux/fish_redux.dart';
import 'package:supernodeapp/common/utils/log.dart';

import 'action.dart';
import 'state.dart';

Reducer<AddGatewayState> buildReducer() {
  return asReducer(
    <Object, Reducer<AddGatewayState>>{
      AddGatewayAction.serialNumber: _serialNumber,
    },
  );
}

AddGatewayState _serialNumber(AddGatewayState state, Action action) {
  String data = action.payload;
  List itemData = data.split(',');

  List snData = itemData[0].split(':');
  String number = snData[1];

  List macData = itemData[itemData.length - 1].split(':');
  String macAddress = macData.sublist(1,4).join().toLowerCase() + 'fffe' + macData.sublist(4).join().toLowerCase();

  final AddGatewayState newState = state.clone();

  return newState
    ..serialNumberCtl.text = number
    ..idCtl.text = macAddress.trim();
}
