import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/column_spacer.dart';
import 'package:supernodeapp/common/components/page/page_frame.dart';
import 'package:supernodeapp/common/components/page/page_nav_bar_back.dart';
import 'package:supernodeapp/common/components/page/submit_button.dart';
import 'package:supernodeapp/common/components/text_field/text_field_with_title.dart';
import 'package:supernodeapp/common/utils/reg.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    ChangePasswordState state, Dispatch dispatch, ViewService viewService) {
  var _ctx = viewService.context;

  return pageFrame(context: viewService.context, children: [
    pageNavBarBack(_ctx, FlutterI18n.translate(_ctx, 'change_password'),
        onTap: () => Navigator.of(viewService.context).pop()),
    Form(
        key: state.formKey,
        child: Column(children: <Widget>[
          bigColumnSpacer(),
          TextFieldWithTitle(
            title: FlutterI18n.translate(_ctx, 'old_password'),
            isObscureText: state.isObscureOldPWDText,
            validator: (value) => Reg.onValidPassword(_ctx, value),
            controller: state.oldPwdCtl,
            suffixChild: IconButton(
                icon: Icon(state.isObscureOldPWDText
                    ? Icons.visibility_off
                    : Icons.visibility),
                onPressed: () => dispatch(
                    ChangePasswordActionCreator.isObscureOldPWDText())),
          ),
          smallColumnSpacer(),
          TextFieldWithTitle(
            title: FlutterI18n.translate(_ctx, 'new_password'),
            isObscureText: state.isObscureNewPWDText,
            validator: (value) => Reg.onValidPassword(_ctx, value),
            controller: state.newPwdCtl,
            suffixChild: IconButton(
                icon: Icon(state.isObscureNewPWDText
                    ? Icons.visibility_off
                    : Icons.visibility),
                onPressed: () => dispatch(
                    ChangePasswordActionCreator.isObscureNewPWDText())),
          ),
          smallColumnSpacer(),
          TextFieldWithTitle(
            title: FlutterI18n.translate(_ctx, 'confirm_new_password'),
            isObscureText: state.isObscureConPWDText,
            validator: (value) =>
                _onValidConfirmPassword(_ctx, value, state.newPwdCtl.text),
            controller: state.confirmNewPwdCtl,
            suffixChild: IconButton(
                icon: Icon(state.isObscureConPWDText
                    ? Icons.visibility_off
                    : Icons.visibility),
                onPressed: () => dispatch(
                    ChangePasswordActionCreator.isObscureConPWDText())),
          ),
        ])),
    submitButton(FlutterI18n.translate(_ctx, 'confirm'),
        onPressed: () => dispatch(ChangePasswordActionCreator.onConfirm()))
  ]);
}

String _onValidConfirmPassword(
    BuildContext context, String value1, String value2) {
  String res = Reg.isEmpty(value1);
  if (res != null) return FlutterI18n.translate(context, res);

  res = Reg.isEqual(value1, value2, 'password');

  if (res != null) {
    return FlutterI18n.translate(context, res);
  }

  return null;
}
