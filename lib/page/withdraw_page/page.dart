import 'package:fish_redux/fish_redux.dart';
import 'enter_securitycode_withdraw_component/component.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class WithdrawPage extends Page<WithdrawState, Map<String, dynamic>> {
  WithdrawPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<WithdrawState>(
                adapter: null,
                slots: <String, Dependent<WithdrawState>>{
                  'enterSecurityCodeWithdraw': EnterSecurityCodeWithdrawConnector() + EnterSecurityCodeWithdrawComponent(),
                  //'recoveryCode': RecoveryCodeConnector() + RecoveryCodeComponent(),
                }),
            middleware: <Middleware<WithdrawState>>[
            ],);

}
