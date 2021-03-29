import 'package:fish_redux/fish_redux.dart';

class ConfirmState implements Cloneable<ConfirmState> {
  String title = '';
  String content = '';
  bool success = false;

  @override
  ConfirmState clone() {
    return ConfirmState()
      ..title = title
      ..content = content
      ..success = success;
  }
}

ConfirmState initState(Map<String, dynamic> args) {
  String title = args['title'];
  String content = args['content'];
  bool success = args.containsKey('success');

  return ConfirmState()
    ..title = title
    ..content = content
    ..success = success;
}
