import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class Set2FAPage extends Page<Set2FAState, Map<String, dynamic>> {
  Set2FAPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<Set2FAState>(
                adapter: null,
                slots: <String, Dependent<Set2FAState>>{
                }),
            middleware: <Middleware<Set2FAState>>[
            ],);

}
