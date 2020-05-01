import 'package:fish_redux/fish_redux.dart';
import 'package:supernodeapp/page/settings_page/organizations_component/state.dart';

class DepositState implements Cloneable<DepositState> {
  String userId = '';
  List<OrganizationsState> organizations = [];
  String address = '';

  @override
  DepositState clone() {
    return DepositState()
      ..userId = userId
      ..organizations = organizations
      ..address = address;
  }
}

DepositState initState(Map<String, dynamic> args) {
  String userId = args['userId'];
  List<OrganizationsState> organizations = args['organizations'];

  return DepositState()
    ..userId = userId
    ..organizations = organizations;
}
