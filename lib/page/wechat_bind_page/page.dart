import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class WechatBindPage extends Page<WechatBindState, Map<String, dynamic>> {
  WechatBindPage()
    : super(
        initState: initState,
        effect: buildEffect(),
        reducer: buildReducer(),
        view: buildView,
        dependencies: Dependencies<WechatBindState>(
            adapter: null,
            slots: <String, Dependent<WechatBindState>>{
            }),
        middleware: <Middleware<WechatBindState>>[
        ],);
}
