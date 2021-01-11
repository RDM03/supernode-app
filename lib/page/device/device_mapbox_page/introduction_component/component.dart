import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class IntroductionComponent extends Component<IntroductionState> {
  IntroductionComponent()
      : super(
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<IntroductionState>(
              adapter: null, slots: <String, Dependent<IntroductionState>>{}),
        );
}
