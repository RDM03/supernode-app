import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/page/done.dart';
import 'package:supernodeapp/common/components/page/page_content.dart';
import 'package:supernodeapp/common/components/page/page_frame.dart';
import 'package:supernodeapp/common/components/page/page_nav_bar.dart';
import 'package:supernodeapp/common/components/page/submit_button.dart';
import 'package:supernodeapp/common/components/page/title.dart';

import 'state.dart';

Widget buildView(
    ConfirmState state, Dispatch dispatch, ViewService viewService) {
  var _ctx = viewService.context;

  return pageFrame(context: viewService.context, children: [
    pageNavBar(FlutterI18n.translate(_ctx, state.title),
        onTap: () => Navigator.pop(viewService.context)),
    title(FlutterI18n.translate(_ctx, state.title)),
    done(
        success:
        state.success || state.content.contains('successful') || state.title == 'confirmed'),
    pageContent(FlutterI18n.translate(_ctx, state.content)),
    submitButton(
      FlutterI18n.translate(_ctx, 'done'),
      onPressed: () => Navigator.pop(viewService.context),
    )
  ]);
}
