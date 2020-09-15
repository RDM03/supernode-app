import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'state.dart';
import 'view.dart';
import 'reducer.dart';

class AddressBookPage extends Page<AddressBookState, Map<String, dynamic>> {
  AddressBookPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
        );
}
