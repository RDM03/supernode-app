import 'package:fish_redux/fish_redux.dart';
import 'package:supernodeapp/common/repositories/supernode/dao/dhx.dart';

import 'action.dart';
import 'state.dart';

Reducer<ListCouncilsState> buildReducer() {
  return asReducer(
    <Object, Reducer<ListCouncilsState>>{
      ListCouncilsAction.councils: _councils,
      ListCouncilsAction.tab: _tab,
    },
  );
}

ListCouncilsState _councils(ListCouncilsState state, Action action) {
  final List<Council> allCouncils = action.payload[0];
  final List<Council> joinedCouncils = action.payload[1];

  final ListCouncilsState newState = state.clone();
  
  allCouncils.sort((item1,item2){
    return double.tryParse(item2.lastMpower).compareTo(double.tryParse(item1.lastMpower));
  });

  return newState
    ..allCouncils = allCouncils
    ..joinedCouncils = joinedCouncils;
}

ListCouncilsState _tab(ListCouncilsState state, Action action) {
  final int tab = action.payload;

  final ListCouncilsState newState = state.clone();
  return newState..tab = tab;
}
