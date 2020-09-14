import 'package:fish_redux/fish_redux.dart';

import 'view.dart';
import 'state.dart';

class CalculatorPage extends Page<CalculatorState, Map<String, dynamic>> {
  CalculatorPage()
      : super(
          initState: initState,
          view: buildView,
        );
}
