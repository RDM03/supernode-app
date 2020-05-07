import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class OrganizationsComponent extends Component<OrganizationsState> {
  OrganizationsComponent()
      : super(
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<OrganizationsState>(
                adapter: null,
                slots: <String, Dependent<OrganizationsState>>{
                }),);

}
