import 'package:fish_redux/fish_redux.dart';

class ConfirmState implements Cloneable<ConfirmState> {

  String title = '';
  String content = '';

  @override
  ConfirmState clone() {
    return ConfirmState()
      ..title = title
      ..content = content;
  }
}

ConfirmState initState(Map<String, dynamic> args) {
  String title = args['title'];
  String content = args['content'];

  return ConfirmState()
    ..title = title
    ..content = content;
}
