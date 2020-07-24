import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class MapBoxPage extends Page<MapBoxState, Map<String, dynamic>> {
  MapBoxPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<MapBoxState>(
                adapter: null,
                slots: <String, Dependent<MapBoxState>>{
                }),
            middleware: <Middleware<MapBoxState>>[ ],
            );


}
