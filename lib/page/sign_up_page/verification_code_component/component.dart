import 'package:fish_redux/fish_redux.dart';
import 'package:supernodeapp/page/sign_up_page/registration_component/component.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class VerificationCodeComponent extends Component<VerificationCodeState> {
  VerificationCodeComponent()
      : super(
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<VerificationCodeState>(
                adapter: null,
                slots: <String, Dependent<VerificationCodeState>>{
                }),);

}
