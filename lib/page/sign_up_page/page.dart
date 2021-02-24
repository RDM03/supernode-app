import 'package:fish_redux/fish_redux.dart';

import 'state.dart';

class SignUpPage extends Page<SignUpState, Map<String, dynamic>> {
  SignUpPage();
      /*: super(
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
        );*/
}
