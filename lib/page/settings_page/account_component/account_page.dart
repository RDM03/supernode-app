import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/page/page_frame.dart';
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
          ListTile(
            title: Center(
                child: Text(FlutterI18n.translate(context, 'manage_account'),
                    style: kBigBoldFontOfBlack)),
            trailing: GestureDetector(
                child: Icon(Icons.close, color: blackColor),
                onTap: () => Navigator.of(context).pop()),
          ),
          Divider(),
          listItem(FlutterI18n.translate(context, 'super_node'),
              key: Key('superNodeItem'),
              onTap: () => Navigator.push(context, route((_) => ProfilePage())),
              leading: Image.asset(Token.mxc.imagePath, height: s(50))),
          Divider(),
          Container(
            color: ColorsTheme.of(context).boxComponents,
            child: ListTile(
              title: Text(
                FlutterI18n.translate(context, 'datahighway_parachain'),
                style: kBigFontOfGrey,
              ),
              onTap: () =>
                  'TODO', //TODO dispatch(SettingsActionCreator.onSettings(SettingsOption.profileDhx)),
              leading: Image.asset(Token.supernodeDhx.imagePath, height: s(50)),
              trailing: Icon(
                Icons.chevron_right,
                color: ColorsTheme.of(context).textLabel,
              ),
            ),
          ),
        ]);
  }
}
