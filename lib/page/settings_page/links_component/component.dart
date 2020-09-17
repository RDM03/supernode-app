import 'package:fish_redux/fish_redux.dart';

import 'state.dart';
import 'view.dart';

class LinksComponent extends Component<LinksState> {
  LinksComponent()
      : super(
          view: buildView,
          dependencies: Dependencies<LinksState>(
              adapter: null, slots: <String, Dependent<LinksState>>{}),
        );
}
