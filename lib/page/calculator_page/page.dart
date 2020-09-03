import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'view.dart';
import 'state.dart';

class CalculatorPage extends Page<CalculatorState, Map<String, dynamic>> {
  CalculatorPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
        );
}
