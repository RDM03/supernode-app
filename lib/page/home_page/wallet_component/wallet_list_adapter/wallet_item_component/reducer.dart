import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<WalletItemState> buildReducer() {
  return asReducer(
    <Object, Reducer<WalletItemState>>{
      WalletItemAction.isExpand: _isExpand,
    },
  );
}

WalletItemState _isExpand(WalletItemState state, Action action) {
  String id = action.payload;
  final WalletItemState newState = state.clone();
  
  if(id == state.id){
    return newState
      ..isExpand = !state.isExpand;
  }
  
  return state;
}
