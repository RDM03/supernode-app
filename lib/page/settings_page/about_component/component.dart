import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class AboutComponent extends Component<AboutState> {
  AboutComponent()
      : super(
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<AboutState>(
              adapter: null, slots: <String, Dependent<AboutState>>{}),
        );
}
