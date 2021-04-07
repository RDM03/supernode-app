import 'package:fish_redux/fish_redux.dart';

import 'state.dart';

Reducer<QRCodeState> buildReducer() {
  return asReducer(
    <Object, Reducer<QRCodeState>>{},
  );
}
