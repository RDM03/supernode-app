import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/buttons/primary_button.dart';
import 'package:supernodeapp/common/components/column_spacer.dart';
import 'package:supernodeapp/common/components/page/paragraph.dart';
import 'package:supernodeapp/common/components/text_field/text_field_with_codes.dart';
import 'package:supernodeapp/common/components/text_field/text_field_with_title.dart';
import 'package:supernodeapp/common/utils/reg.dart';
import 'package:supernodeapp/page/forgot_password_page/password_reset_component/action.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/spacing.dart';

import '../action.dart';
import 'state.dart';

Widget buildView(
    PasswordResetState state, Dispatch dispatch, ViewService viewService) {
  var _ctx = viewService.context;

  return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: cardBackgroundColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
          child: Container(
              padding: kRoundRow2002,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  paragraph(FlutterI18n.translate(_ctx, 'send_email')),
                  Form(
                    key: state.formKey,
                    autovalidate: false,
                    child: Column(children: <Widget>[
                      Container(
                        margin: kOuterRowTop35,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: state.listCtls
                              .asMap()
                              .keys
                              .map((index) => textfieldWithCodes(
                                    context: _ctx,
                                    controller: state.listCtls[index],
                                    isLast: index == state.listCtls.length - 1,
                                  ))
                              .toList(),
                        ),
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
                            onPressed: () => dispatch(PasswordResetActionCreator
                                .isObscureNewPWDText())),
                      ),
                      smallColumnSpacer(),
                      TextFieldWithTitle(
                        title:
                            FlutterI18n.translate(_ctx, 'confirm_new_password'),
                        isObscureText: state.isObscureConPWDText,
                        validator: (value) => _onValidConfirmPassword(
                            _ctx, value, state.newPwdCtl.text),
                        controller: state.confirmNewPwdCtl,
                        suffixChild: IconButton(
                            icon: Icon(state.isObscureConPWDText
                                ? Icons.visibility_off
                                : Icons.visibility),
                            onPressed: () => dispatch(PasswordResetActionCreator
                                .isObscureConPWDText())),
                      ),
                    ]),
                  ),
                  Spacer(),
                  PrimaryButton(
                      onTap: () => dispatch(
                          ForgotPasswordActionCreator.onVerificationContinue()),
                      buttonTitle: FlutterI18n.translate(_ctx, 'confirm'),
                      minHeight: 46),
                ],
              ))));
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
