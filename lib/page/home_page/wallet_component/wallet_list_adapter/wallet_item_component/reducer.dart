import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<GeneralItemState> buildReducer() {
  return asReducer(
    <Object, Reducer<GeneralItemState>>{
      WalletItemAction.isExpand: _isExpand,
    },
  );
}

WalletItemState _isExpand(GeneralItemState state, Action action) {
  GeneralItemState id = action.payload;
  
  if(id == state){
    return state.copyWithExtend(!state.isExpand);
  }
  
  return state;
}
