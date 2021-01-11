import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'registration_component/component.dart';
import 'state.dart';
import 'verification_code_component/component.dart';
import 'view.dart';

class SignUpPage extends Page<SignUpState, Map<String, dynamic>> {
  SignUpPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<SignUpState>(
              adapter: null,
              slots: <String, Dependent<SignUpState>>{
                'verification':
                    VerificationCodeConnector() + VerificationCodeComponent(),
                'registration':
                    RegistrationConnector() + RegistrationComponent(),
                // 'add_gateway': AddGatewayConnector() + AddGatewayComponent(),
              }),
          middleware: <Middleware<SignUpState>>[],
        );
}
