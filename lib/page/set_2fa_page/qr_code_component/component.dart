import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class QRCodeComponent extends Component<QRCodeState> {
  QRCodeComponent()
      : super(
    effect: buildEffect(),
    reducer: buildReducer(),
    view: buildView,
    dependencies: Dependencies<QRCodeState>(
        adapter: null,
        slots: <String, Dependent<QRCodeState>>{
        }),);

}

