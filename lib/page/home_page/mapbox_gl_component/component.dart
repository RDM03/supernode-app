import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class MapboxGlComponent extends Component<MapboxGlState> {
  MapboxGlComponent()
      : super(
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<MapboxGlState>(
                adapter: null,
                slots: <String, Dependent<MapboxGlState>>{
                }),);

}
