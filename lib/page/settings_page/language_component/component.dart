import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class LanguageComponent extends Component<LanguageState> {
  LanguageComponent()
      : super(
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<LanguageState>(
                adapter: null,
                slots: <String, Dependent<LanguageState>>{
                }),);

}
