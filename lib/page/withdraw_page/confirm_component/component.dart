import 'package:fish_redux/fish_redux.dart';

import 'state.dart';
import 'view.dart';

class ConfirmComponent extends Component<ConfirmState> {
  ConfirmComponent()
      : super(
          view: buildView,
          dependencies: Dependencies<ConfirmState>(
              adapter: null, slots: <String, Dependent<ConfirmState>>{}),
        );
}
