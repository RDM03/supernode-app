import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/page/done.dart';
import 'package:supernodeapp/common/components/page/page_frame.dart';
import 'package:supernodeapp/common/components/page/page_nav_bar.dart';
import 'package:supernodeapp/common/components/page/submit_button.dart';
import 'package:supernodeapp/common/components/page/title.dart';
import 'package:supernodeapp/common/utils/navigator.dart';
import 'package:supernodeapp/theme/theme.dart';

import 'state.dart';

Widget buildView(
    ConfirmState state, Dispatch dispatch, ViewService viewService) {
  var _ctx = viewService.context;

  return pageFrame(context: viewService.context, children: [
    pageNavBar(FlutterI18n.translate(_ctx, state.title),
        onTap: () => popAllPages(_ctx)),
    title(FlutterI18n.translate(_ctx, state.title)),
    done(
        success: state.success ||
            state.content.contains('successful') ||
            state.title == 'confirmed'),
    Container(
      margin: EdgeInsets.only(top: 50),
      alignment: Alignment.center,
      child: Text(
        state.content,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: ColorsTheme.of(_ctx).textPrimaryAndIcons,
          fontFamily: "Roboto",
          fontWeight: FontWeight.w400,
          decoration: TextDecoration.none,
          fontSize: 14,
          height: 1.42857,
        ),
      ),
    ),
    submitButton(
      FlutterI18n.translate(_ctx, 'done'),
      key: Key('doneButton'),
      onPressed: () => popAllPages(_ctx),
    )
  ]);
}
