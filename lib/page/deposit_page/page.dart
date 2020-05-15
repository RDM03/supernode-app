import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class DepositPage extends Page<DepositState, Map<String, dynamic>> {
  DepositPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<DepositState>(
                adapter: null,
                slots: <String, Dependent<DepositState>>{
                }),
            middleware: <Middleware<DepositState>>[
            ],);

}
