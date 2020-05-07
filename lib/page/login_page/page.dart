import 'package:fish_redux/fish_redux.dart';
import 'package:supernodeapp/page/home_page/user_component/state.dart';

import 'effect.dart';
import 'reducer.dart';
import 'view.dart';

class LoginPage extends Page<UserState, Map<String, dynamic>> {
  LoginPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<UserState>(
                adapter: null,
                slots: <String, Dependent<UserState>>{
                }),
            middleware: <Middleware<UserState>>[
            ],);

}
