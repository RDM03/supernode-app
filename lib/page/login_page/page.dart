import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'view.dart';
import 'state.dart';

class LoginPage extends Page<LoginState, Map<String, dynamic>> {
  LoginPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<LoginState>(
                adapter: null,
                slots: <String, Dependent<LoginState>>{
                }),
            middleware: <Middleware<LoginState>>[
            ],);

}
