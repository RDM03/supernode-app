import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class AddAddressPage extends Page<AddAddressState, Map<String, dynamic>> {
  AddAddressPage()
      : super(
          view: buildView,
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
        );
}
