import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class WechatBindNewAccPage
    extends Page<WechatBindNewAccState, Map<String, dynamic>> {
  WechatBindNewAccPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<WechatBindNewAccState>(
              adapter: null,
              slots: <String, Dependent<WechatBindNewAccState>>{}),
          middleware: <Middleware<WechatBindNewAccState>>[],
        );
}
