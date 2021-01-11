import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class SecurityComponent extends Component<SecurityState> {
  SecurityComponent()
      : super(
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<SecurityState>(
              adapter: null, slots: <String, Dependent<SecurityState>>{}),
        );
}
