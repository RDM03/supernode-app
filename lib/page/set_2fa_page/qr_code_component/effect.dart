import 'package:fish_redux/fish_redux.dart';

import 'state.dart';

Effect<QRCodeState> buildEffect() {
  return combineEffects(<Object, Effect<QRCodeState>>{});
}
