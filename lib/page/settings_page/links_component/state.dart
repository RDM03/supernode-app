import 'package:fish_redux/fish_redux.dart';

class LinksState implements Cloneable<LinksState> {
  @override
  LinksState clone() {
    return LinksState();
  }
}

LinksState initState(Map<String, dynamic> args) {
  return LinksState();
}
