import 'package:fish_redux/fish_redux.dart';

import 'state.dart';

Reducer<UserState> buildReducer() {
  return asReducer(
    <Object, Reducer<UserState>>{},
  );
}
