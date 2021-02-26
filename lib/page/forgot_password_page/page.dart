import 'package:fish_redux/fish_redux.dart';
import 'package:supernodeapp/page/forgot_password_page/password_reset_component/component.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class ForgotPasswordPage
    extends Page<ForgotPasswordState, Map<String, dynamic>> {
  ForgotPasswordPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<ForgotPasswordState>(
              adapter: null,
              slots: <String, Dependent<ForgotPasswordState>>{
                'pwd_reset':
                    PasswordResetConnector() + PasswordResetComponent(),
              }),
          middleware: <Middleware<ForgotPasswordState>>[],
        );
}
