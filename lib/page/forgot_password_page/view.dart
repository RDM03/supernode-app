import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/buttons/primary_button.dart';
import 'package:supernodeapp/common/components/page/paragraph.dart';
import 'package:supernodeapp/common/components/text_field/text_field_with_title.dart';
import 'package:supernodeapp/common/utils/reg.dart';
import 'package:supernodeapp/common/utils/screen_util.dart';
import 'package:supernodeapp/page/forgot_password_page/action.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/font.dart';
import 'package:supernodeapp/theme/spacing.dart';
import 'package:supernodeapp/theme/theme.dart';

import 'state.dart';

Widget buildView(
    ForgotPasswordState state, Dispatch dispatch, ViewService viewService) {
  var _ctx = viewService.context;

  return Scaffold(
    backgroundColor: ColorsTheme.of(_ctx).secondaryBackground,
    appBar: AppBar(
      iconTheme: IconThemeData(color: ColorsTheme.of(_ctx).textPrimaryAndIcons),
      backgroundColor: Colors.transparent,
      elevation: 0,
    ),
    body: SafeArea(
      child: Container(
        padding: kRoundRow2002,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            paragraph('${FlutterI18n.translate(_ctx, 'welcome')},'),
            paragraph('${FlutterI18n.translate(_ctx, 'change_password_hint')}'),
            Form(
              key: state.emailFormKey,
              autovalidate: false,
              child: Column(children: <Widget>[
                Container(
                  margin: kOuterRowTop35,
                  child: TextFieldWithTitle(
                    title: FlutterI18n.translate(_ctx, 'email'),
                    hint: FlutterI18n.translate(_ctx, 'email_hint'),
                    textInputAction: TextInputAction.done,
                    validator: (value) => Reg.onValidEmail(_ctx, value),
                    controller: state.emailCtl,
                  ),
                ),
                SizedBox(height: 10),
                GestureDetector(
                  onTap: () =>
                      dispatch(ForgotPasswordActionCreator.onHasCode()),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: 2),
                    child: Text(
                      FlutterI18n.translate(_ctx, 'have_code'),
                      style: FontTheme.of(_ctx).middle.secondary.underline(),
                    ),
                  ),
                ),
              ]),
            ),
            Spacer(),
            PrimaryButton(
                onTap: () =>
                    dispatch(ForgotPasswordActionCreator.onEmailContinue()),
                buttonTitle: FlutterI18n.translate(_ctx, 'continue'),
                minHeight: 46),
            SizedBox(height: s(54)),
          ],
        ),
      ),
    ),
  );
}
