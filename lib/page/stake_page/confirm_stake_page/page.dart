import 'package:fish_redux/fish_redux.dart';

import 'state.dart';
import 'view.dart';

class ConfirmStakePage extends Page<ConfirmStakeState, Map<String, dynamic>> {
  ConfirmStakePage()
      : super(
          initState: initState,
          view: buildView,
        );
}
