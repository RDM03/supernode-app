import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/page/page_frame.dart';
import 'package:supernodeapp/common/components/page/page_nav_bar.dart';
import 'package:supernodeapp/common/components/settings/list_item.dart';
import 'package:supernodeapp/common/utils/currencies.dart';
import 'package:supernodeapp/common/utils/screen_util.dart';
import 'package:supernodeapp/page/settings_page/profile_component/profile_page.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/font.dart';
import 'package:supernodeapp/theme/theme.dart';

import '../../../route.dart';

class AccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return pageFrame(
      context: context,
      padding: EdgeInsets.all(0.0),
      children: <Widget>[
        PageNavBar.settings(
          text: FlutterI18n.translate(context, 'manage_account'),
        ),
        listItem(
          FlutterI18n.translate(context, 'super_node'),
          key: Key('superNodeItem'),
          onTap: () => Navigator.push(context, route((_) => ProfilePage())),
          leading: Image(
            image: Token.mxc.ui(context).image,
            height: s(50),
          ),
        ),
        Container(
          color: ColorsTheme.of(context).boxComponents,
          child: ListTile(
            title: Text(
              FlutterI18n.translate(context, 'datahighway_parachain'),
              style: FontTheme.of(context).big.secondary(),
            ),
            onTap: () =>
                'TODO', //TODO dispatch(SettingsActionCreator.onSettings(SettingsOption.profileDhx)),
            leading: Image(
                image: Token.supernodeDhx.ui(context).image, height: s(50)),
            trailing: Icon(
              Icons.chevron_right,
              color: ColorsTheme.of(context).textLabel,
            ),
          ),
        ),
      ],
    );
  }
}
