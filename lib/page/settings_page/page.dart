import 'package:fish_redux/fish_redux.dart';
import 'package:supernodeapp/page/settings_page/links_component/component.dart';

import 'about_component/component.dart';
import 'effect.dart';
import 'language_component/component.dart';
import 'organizations_component/component.dart';
import 'profile_component/component.dart';
import 'reducer.dart';
import 'security_component/component.dart';
import 'state.dart';
import 'view.dart';

class SettingsPage extends Page<SettingsState, Map<String, dynamic>> {
  SettingsPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<SettingsState>(
            adapter: null,
            slots: <String, Dependent<SettingsState>>{
              'profile': ProfileConnector() + ProfileComponent(),
              'organization':
                  OrganizationConnector() + OrganizationsComponent(),
              'security': SecurityConnector() + SecurityComponent(),
              'language': LanguageConnector() + LanguageComponent(),
              'about': AboutConnector() + AboutComponent(),
              'links': LinksConnector() + LinksComponent(),
            },
          ),
          middleware: <Middleware<SettingsState>>[],
        );
}
