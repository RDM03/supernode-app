import 'package:fish_redux/fish_redux.dart';
import 'package:supernodeapp/common/daos/dhx_dao.dart';

import 'action.dart';
import 'state.dart';

Reducer<JoinCouncilState> buildReducer() {
  return asReducer(
    <Object, Reducer<JoinCouncilState>>{
      JoinCouncilAction.resSuccess: _resSuccess,
      JoinCouncilAction.councils: _councils,
    },
  );
}

JoinCouncilState _resSuccess(JoinCouncilState state, Action action) {
  bool resSuccess = action.payload;

  final JoinCouncilState newState = state.clone();
  return newState..resSuccess = resSuccess;
}

JoinCouncilState _councils(JoinCouncilState state, Action action) {
  List<Council> councils = action.payload;

  final JoinCouncilState newState = state.clone();
  return newState..councils = councils;
}
