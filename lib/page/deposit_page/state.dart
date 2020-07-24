import 'package:fish_redux/fish_redux.dart';
import 'package:supernodeapp/page/settings_page/organizations_component/state.dart';

class DepositState implements Cloneable<DepositState> {
  String userId = '';
  List<OrganizationsState> organizations = [];
  String address = '';
  bool isDemo;

  @override
  DepositState clone() {
    return DepositState()
      ..userId = userId
      ..organizations = organizations
      ..address = address
      ..isDemo = isDemo;
  }
}

DepositState initState(Map<String, dynamic> args) {
  String userId = args['userId'];
  List<OrganizationsState> organizations = args['organizations'];
  bool isDemo = args['isDemo'] ?? false;

  return DepositState()
    ..userId = userId
    ..organizations = organizations
    ..isDemo = isDemo;
}
