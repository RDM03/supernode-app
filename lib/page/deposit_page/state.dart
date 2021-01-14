import 'package:fish_redux/fish_redux.dart';
import 'package:supernodeapp/common/repositories/supernode/dao/user.model.dart';

class DepositState implements Cloneable<DepositState> {
  String userId = '';
  String orgId = '';
  String address = '';
  bool isDemo;

  @override
  DepositState clone() {
    return DepositState()
      ..userId = userId
      ..orgId = orgId
      ..address = address
      ..isDemo = isDemo;
  }
}

DepositState initState(Map<String, dynamic> args) {
  String userId = args['userId'].toString();
  String orgId = args['orgId'];
  bool isDemo = args['isDemo'] ?? false;

  return DepositState()
    ..userId = userId
    ..orgId = orgId
    ..isDemo = isDemo;
}
