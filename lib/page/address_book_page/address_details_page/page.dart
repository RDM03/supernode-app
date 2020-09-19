import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class AddressDetailsPage
    extends Page<AddressDetailsState, Map<String, dynamic>> {
  AddressDetailsPage()
      : super(
          view: buildView,
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
        );
}
