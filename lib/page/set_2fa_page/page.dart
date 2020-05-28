import 'package:fish_redux/fish_redux.dart';
import 'enter_securitycode_component/component.dart';
import 'recovery_code_component/component.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class Set2FAPage extends Page<Set2FAState, Map<String, dynamic>> {
  Set2FAPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<Set2FAState>(
                adapter: null,
                slots: <String, Dependent<Set2FAState>>{
                  'enterSecurityCode': EnterSecurityCodeConnector() + EnterSecurityCodeComponent(),
                  'recoveryCode': RecoveryCodeConnector() + RecoveryCodeComponent(),
                }),
            middleware: <Middleware<Set2FAState>>[
            ],);

}
