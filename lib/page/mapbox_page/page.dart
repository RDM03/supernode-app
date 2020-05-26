import 'package:fish_redux/fish_redux.dart';
import 'effect.dart';
import 'reducer.dart';
import 'view.dart';
import 'state.dart';

class mapboxPage extends Page<mapboxState, Map<String, dynamic>> {
  mapboxPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<mapboxState>(
                adapter: null,
                slots: <String, Dependent<mapboxState>>{
                }),
            middleware: <Middleware<mapboxState>>[ ],
            );


}
