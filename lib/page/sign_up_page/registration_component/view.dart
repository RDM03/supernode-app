import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/buttons/primary_button.dart';
import 'package:supernodeapp/common/components/checkbox_with_label.dart';
import 'package:supernodeapp/common/components/page/link.dart';
import 'package:supernodeapp/common/components/text_field/text_field_with_title.dart';
import 'package:supernodeapp/common/configs/sys.dart';
import 'package:supernodeapp/common/utils/reg.dart';
import 'package:supernodeapp/common/utils/tools.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/spacing.dart';

import '../action.dart';
import 'action.dart';
import 'state.dart';

Widget buildView(RegistrationState state, Dispatch dispatch, ViewService viewService) {
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
        padding: kRoundRow202,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Form(
              key: state.formKey,
              autovalidate: false,
              child: Column(
                children: <Widget>[
                  Container(
                    margin: kOuterRowTop35,
                    child: TextFieldWithTitle(
                      readOnly: true,
                      title: FlutterI18n.translate(_ctx, 'email'),
                      hint: FlutterI18n.translate(_ctx, 'email_hint'),
                      textInputAction: TextInputAction.next,
                      validator: (value) => Reg.onValidEmail(_ctx,value),
                      controller: state.emailCtl,
                    ),
                  ),
                  Container(
                    margin: kOuterRowTop10,
                    child: TextFieldWithTitle(
                      title: FlutterI18n.translate(_ctx, 'password'),
                      isObscureText: state.isObscureText,
                      // hint: FlutterI18n.translate(_ctx, 'password_hint'),
                      textInputAction: TextInputAction.next,
                      validator: (value) => Reg.onValidPassword(_ctx,value),
                      controller: state.pwdCtl,
                      suffixChild: IconButton(
                        icon: Icon( state.isObscureText ? Icons.visibility_off : Icons.visibility),
                        onPressed: () => dispatch(RegistrationActionCreator.isObscureText())
                      ),
                    ),
                  ),
                  Container(
                    margin: kOuterRowTop10,
                    child: TextFieldWithTitle(
                      title: FlutterI18n.translate(_ctx, 'organization_name'),
                      // hint: FlutterI18n.translate(_ctx, 'organization_name_hint'),
                      textInputAction: TextInputAction.next,
                      validator: (value) => Reg.onNotEmpty(_ctx,value),
                      controller:
                      state.orgCtl..text=state.orgCtl.text==""?state.emailCtl.text.split('@')[0]:state.orgCtl.text,

                    ),
                  ),
                  Container(
                    margin: kOuterRowTop10,
                    child: TextFieldWithTitle(
                      title: FlutterI18n.translate(_ctx, 'display_name'),
                      // hint: FlutterI18n.translate(_ctx, 'display_name_hint'),
                      textInputAction: TextInputAction.done,
                      validator: (value) => Reg.onNotEmpty(_ctx,value),
                      controller:
                      state.displayCtl..text=state.displayCtl.text==""?state.emailCtl.text.split('@')[0]:state.displayCtl.text,
                    ),
                  ),
                ]
              ),
            ),
            Spacer(),
            Container(
              padding: kRoundRow202,
              child: link(
                FlutterI18n.translate(_ctx, 'privacy_policy'),
                onTap: () => Tools.launchURL(Sys.privacyPolicy),
                alignment: Alignment.centerLeft
              ),
            ),
            checkbox_with_label(
              value: state.isCheckTerms,
              widget:  link(
                  FlutterI18n.translate(_ctx, 'agree_conditions'),
                  onTap: () => Tools.launchURL(Sys.AgreePolicy),
                  alignment: Alignment.centerLeft
              ),
              onChanged: (_) => dispatch(RegistrationActionCreator.isCheckTerms())
            ),
            checkbox_with_label(
              value: state.isCheckSend,
              label: FlutterI18n.translate(_ctx, 'send_marking_information'),
              onChanged: (_) => dispatch(RegistrationActionCreator.isCheckSend())
            ),
            Spacer(),
            PrimaryButton(
              onTap: () => dispatch(SignUpActionCreator.onRegistrationContinue()),
              buttonTitle: FlutterI18n.translate(_ctx, 'next'),
              minHeight: 46
            ),
          ],
        )
      )
    )
  );
}
