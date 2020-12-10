import 'package:fish_redux/fish_redux.dart';

import 'state.dart';
import 'view.dart';

class LockPage extends Page<LockState, Map<String, dynamic>> {
  LockPage()
      : super(
          initState: initState,
          view: buildView,
        );
}
