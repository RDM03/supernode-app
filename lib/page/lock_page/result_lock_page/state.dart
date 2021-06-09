import 'package:fish_redux/fish_redux.dart';

class ResultLockPageState implements Cloneable<ResultLockPageState> {
  bool isDemo;
  String transactionId;
  String title;
  String content;

  @override
  ResultLockPageState clone() {
    return ResultLockPageState()
      ..isDemo = isDemo
      ..transactionId = transactionId
      ..title = title
      ..content = content;
  }
}

ResultLockPageState initState(Map<String, dynamic> args) {
  bool isDemo = args['isDemo'] ?? false;
  String transactionId = args['stakeId'] ?? '';
  String title = args['title'];
  String content = args['content'];

  return ResultLockPageState()
    ..isDemo = isDemo
    ..transactionId = transactionId
    ..title = title
    ..content = content;
}
