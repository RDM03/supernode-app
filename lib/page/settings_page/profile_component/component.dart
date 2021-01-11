import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class ProfileComponent extends Component<ProfileState> {
  ProfileComponent()
      : super(
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<ProfileState>(
              adapter: null, slots: <String, Dependent<ProfileState>>{}),
        );
}
