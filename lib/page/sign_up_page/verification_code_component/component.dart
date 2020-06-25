import 'package:fish_redux/fish_redux.dart';

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
