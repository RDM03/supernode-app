import 'package:fish_redux/fish_redux.dart';
import 'package:supernodeapp/common/repositories/supernode/dao/stake.dart';

class ListUnstakeState implements Cloneable<ListUnstakeState> {
  bool isDemo = false;
  bool isLoading = true;
  List<Stake> stakes = [];

  @override
  ListUnstakeState clone() {
    return ListUnstakeState()
      ..isLoading = isLoading
      ..isDemo = isDemo
      ..stakes = stakes;
  }
}

ListUnstakeState initState(Map<String, dynamic> args) {
  bool isDemo = args['isDemo'] ?? false;

  return ListUnstakeState()..isDemo = isDemo;
}
