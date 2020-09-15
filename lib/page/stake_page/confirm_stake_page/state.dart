import 'package:fish_redux/fish_redux.dart';

class ConfirmStakeState implements Cloneable<ConfirmStakeState> {
  DateTime endDate;
  String amount;
  DateTime openTime;

  @override
  ConfirmStakeState clone() {
    return ConfirmStakeState()
      ..endDate = endDate
      ..amount = amount
      ..openTime = openTime;
  }
}

ConfirmStakeState initState(Map<String, dynamic> args) {
  args ??= {};
  DateTime endDate = args['endDate'];
  String amount = args['amount'] ?? '0';

  return ConfirmStakeState()
    ..endDate = endDate
    ..amount = amount
    ..openTime = DateTime.now();
}
