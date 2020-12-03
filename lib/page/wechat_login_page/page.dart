import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'state.dart';
import 'view.dart';

class WechatLoginPage extends Page<WechatLoginState, Map<String, dynamic>> {
  WechatLoginPage()
    : super(
        initState: initState,
        effect: buildEffect(),
        reducer: null,
        view: buildView,
        dependencies: Dependencies<WechatLoginState>(
            adapter: null,
            slots: <String, Dependent<WechatLoginState>>{
            }),
        middleware: <Middleware<WechatLoginState>>[
        ],);
}
