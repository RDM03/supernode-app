import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/column_spacer.dart';
import 'package:supernodeapp/common/components/page/page_frame.dart';
import 'package:supernodeapp/common/components/page/page_nav_bar.dart';
import 'package:supernodeapp/common/components/page/submit_button.dart';
import 'package:supernodeapp/common/components/profile.dart';
import 'package:supernodeapp/common/components/text_field/text_field_with_title.dart';
import 'package:supernodeapp/common/utils/reg.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    ProfileState state, Dispatch dispatch, ViewService viewService) {
  var _ctx = viewService.context;
  return pageFrame(context: viewService.context, children: [
    pageNavBar(FlutterI18n.translate(_ctx, 'profile_setting'),
        onTap: () => Navigator.of(viewService.context).pop()),
    profile(
      contentPadding: const EdgeInsets.symmetric(vertical: 20),
      name: state.username,
      position: state.isAdmin ? FlutterI18n.translate(_ctx, 'admin') : '',
    ),
    Form(
      key: state.formKey,
      child: Column(children: <Widget>[
        TextFieldWithTitle(
          title: FlutterI18n.translate(_ctx, 'username'),
          validator: (value) => _validUsername(_ctx, value),
          controller: state.usernameCtl,
        ),
        smallColumnSpacer(),
        TextFieldWithTitle(
          title: FlutterI18n.translate(_ctx, 'email'),
          validator: (value) => _validEmail(_ctx, value),
          controller: state.emailCtl,
        ),
      ]),
    ),
    submitButton(FlutterI18n.translate(_ctx, 'update'),
        onPressed: () => dispatch(ProfileActionCreator.onUpdate()))
  ]);
}

String _validUsername(BuildContext context, String value) {
  String res = Reg.isEmpty(value);
  if (res != null) {
    return FlutterI18n.translate(context, res);
  }

  return null;
}

String _validEmail(BuildContext context, String value) {
  String res = Reg.isEmpty(value);
  if (res != null) return FlutterI18n.translate(context, res);

  res = Reg.isEmail(value);
  if (res != null) {
    return FlutterI18n.translate(context, res);
  }

  return null;
}
