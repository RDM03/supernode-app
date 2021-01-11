import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<OrganizationsState> buildReducer() {
  return asReducer(
    <Object, Reducer<OrganizationsState>>{
      OrganizationsAction.selectedItem: _selectedItem,
    },
  );
}

OrganizationsState _selectedItem(OrganizationsState state, Action action) {
  Map data = action.payload;
  String id = data['id'];
  String name = data['name'];

  final OrganizationsState newState = state.clone();
  return newState
    ..selectedOrgId = id
    ..selectedOrgName = name
    ..orgListCtl.text = name
    ..orgDisplayCtl.text = name
    ..orgNameCtl.text = name;
}
