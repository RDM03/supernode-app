import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/page/page_frame.dart';
import 'package:supernodeapp/common/components/page/page_nav_bar.dart';
import 'package:supernodeapp/common/components/settings/list_item.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(SecurityState state, Dispatch dispatch, ViewService viewService) {
  var _ctx = viewService.context;

  return pageFrame(
    context: viewService.context,
    padding: EdgeInsets.zero,
    children: [
      pageNavBar(
        FlutterI18n.translate(_ctx,'security_setting'),
        padding: const EdgeInsets.all(20),
        onTap: () => Navigator.of(viewService.context).pop()
      ),
      listItem(
        FlutterI18n.translate(_ctx,'change_password'),
        onTap: () => Navigator.of(viewService.context).pushNamed('change_password_page')
      ),
      listItem(
          FlutterI18n.translate(_ctx,'set_fa_02'),
          onTap: () => Navigator.of(viewService.context).pushNamed('set_2fa_page', arguments:{'isEnabled': false})
      ),
      Divider()
    ]
  );
}
