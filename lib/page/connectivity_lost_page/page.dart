import 'package:fish_redux/fish_redux.dart';
import 'view.dart';

class ConnectivityLostPage extends Page<bool, Map<String, dynamic>> {
  ConnectivityLostPage()
      : super(
          initState: (_) => false,
          view: buildView,
        );
}
