import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class RecoveryCodeComponent extends Component<RecoveryCodeState> {
  RecoveryCodeComponent()
      : super(
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<RecoveryCodeState>(
                adapter: null,
                slots: <String, Dependent<RecoveryCodeState>>{
                }),);

}
