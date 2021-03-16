import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/buttons/primary_button.dart';
import 'package:supernodeapp/common/components/column_spacer.dart';
import 'package:supernodeapp/common/components/page/done.dart';
import 'package:supernodeapp/common/components/page/page_content.dart';
import 'package:supernodeapp/common/components/page/page_frame.dart';
import 'package:supernodeapp/common/components/page/page_nav_bar.dart';
import 'package:supernodeapp/common/components/page/title.dart';

import 'state.dart';

Widget buildView(
    ConfirmState state, Dispatch dispatch, ViewService viewService) {
  var _ctx = viewService.context;

  return pageFrame(context: viewService.context,
      children: [
        pageNavBar(FlutterI18n.translate(_ctx, state.title),
            leadingWidget: SizedBox(),
            onTap: () => Navigator.pop(viewService.context)),
        title(FlutterI18n.translate(_ctx, 'confirmed')),
        done(
            success:
            FlutterI18n.translate(_ctx, state.content).contains('successful') || state.title == 'confirmed'),
        pageContent(FlutterI18n.translate(_ctx, state.content)),
        xbigColumnSpacer(),
        PrimaryButton(
          buttonTitle: FlutterI18n.translate(_ctx, 'done'),
          onTap: () => Navigator.pop(viewService.context),
          minWidth: double.infinity
        )
      ]);
}
