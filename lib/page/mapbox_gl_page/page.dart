import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class MapboxGlPage extends Page<MapboxGlState, Map<String, dynamic>> {
  MapboxGlPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<MapboxGlState>(
              adapter: null, slots: <String, Dependent<MapboxGlState>>{}),
        );
}
