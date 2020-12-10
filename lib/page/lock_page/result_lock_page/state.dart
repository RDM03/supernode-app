import 'package:fish_redux/fish_redux.dart';

class ResultLockPageState implements Cloneable<ResultLockPageState> {
  bool isDemo;
  String transactionId;

  @override
  ResultLockPageState clone() {
    return ResultLockPageState()
      ..isDemo = isDemo
      ..transactionId = transactionId;
  }
}

ResultLockPageState initState(Map<String, dynamic> args) {
  bool isDemo = args['isDemo'] ?? false;
  String transactionId = args['transactionId'] ?? '??';
  return ResultLockPageState()
    ..isDemo = isDemo
    ..transactionId = transactionId;
}
