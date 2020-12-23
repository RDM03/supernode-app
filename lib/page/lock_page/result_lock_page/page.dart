import 'package:fish_redux/fish_redux.dart';
import 'state.dart';
import 'view.dart';

class ResultLockPage extends Page<ResultLockPageState, Map<String, dynamic>> {
  ResultLockPage()
      : super(
          initState: initState,
          view: buildView,
        );
}
