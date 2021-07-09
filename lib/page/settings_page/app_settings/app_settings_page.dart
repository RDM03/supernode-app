import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/page/page_frame.dart';
import 'package:supernodeapp/common/components/settings/list_item.dart';
import 'package:supernodeapp/page/feedback_page/feedback.dart';
import 'package:supernodeapp/page/settings_page/bloc/settings/cubit.dart';
import 'package:supernodeapp/page/settings_page/bloc/settings/state.dart';
import 'package:supernodeapp/page/settings_page/language_component/language_page.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/font.dart';
import 'package:supernodeapp/theme/theme.dart';

import '../../../route.dart';

class AppSettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      buildWhen: (a, b) => a.language != b.language,
      builder: (ctx, s) => pageFrame(
          context: context,
          padding: EdgeInsets.all(0.0),
          children: <Widget>[
            ListTile(
              title: Center(
                  child: Text(FlutterI18n.translate(context, 'app_settings'),
                      key: Key('appSettingsTitle'),
                      style: kBigBoldFontOfBlack)),
              trailing: GestureDetector(
                  child: Icon(Icons.close, color: blackColor),
                  onTap: () => Navigator.of(context).pop()),
            ),
            Divider(),
            listItem(FlutterI18n.translate(context, 'language'),
                key: Key('languageItem'),
                onTap: () =>
                    Navigator.push(context, route((_) => LanguagePage()))),
            Divider(),
            listItem(
              FlutterI18n.translate(context, 'use_face_id'),
              trailing: Switch(
                activeColor: ColorsTheme.of(context).mxcBlue,
                value: true,
                onChanged: (v) => 'TODO',
              ),
            ),
            Divider(),
            listItem(
              FlutterI18n.translate(context, 'screenshot'),
              trailing: BlocBuilder<SettingsCubit, SettingsState>(
                buildWhen: (a, b) => a.screenShot != b.screenShot,
                builder: (ctx, s) => Switch(
                  key: Key('screenshotSwitch'),
                  activeColor: ColorsTheme.of(context).mxcBlue,
                  value: s.screenShot,
                  onChanged: (v) async {
                    await DatadashFeedback.of(context).setShowScreenshot(v);
                    context.read<SettingsCubit>().setScreenShot(v);
                  },
                ),
              ),
            ),
          ]),
    );
  }
}
