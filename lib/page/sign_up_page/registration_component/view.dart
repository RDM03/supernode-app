import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/buttons/primary_button.dart';
import 'package:supernodeapp/common/components/checkbox_with_label.dart';
import 'package:supernodeapp/common/components/page/link.dart';
import 'package:supernodeapp/common/components/text_field/text_field_with_title.dart';
import 'package:supernodeapp/configs/sys.dart';
import 'package:supernodeapp/common/utils/reg.dart';
import 'package:supernodeapp/common/utils/tools.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/spacing.dart';
import 'package:supernodeapp/common/components/widgets/component_widgets.dart';

import '../action.dart';
import 'action.dart';
import 'state.dart';

Widget buildView(RegistrationState state, Dispatch dispatch, ViewService viewService) {
  final _ctx = viewService.context;

  return ScaffoldWidget(
    appBar: AppBar(
      iconTheme: IconThemeData(color: Colors.black),
      backgroundColor: Colors.transparent,
      elevation: 0,
    ),
    padding: kRoundRow202,
    body: Column(
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
                  validator: (value) => Reg.onValidEmail(_ctx, value),
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
                  validator: (value) => Reg.onValidPassword(_ctx, value),
                  controller: state.pwdCtl,
                  suffixChild: IconButton(
                    icon: Icon(state.isObscureText ? Icons.visibility_off : Icons.visibility),
                    onPressed: () => dispatch(RegistrationActionCreator.isObscureText()),
                  ),
                ),
              ),
              Container(
                margin: kOuterRowTop10,
                child: TextFieldWithTitle(
                  title: FlutterI18n.translate(_ctx, 'organization_name'),
                  // hint: FlutterI18n.translate(_ctx, 'organization_name_hint'),
                  textInputAction: TextInputAction.next,
                  validator: (value) => Reg.onNotEmpty(_ctx, value),
                  controller: state.orgCtl
                    ..text = state.orgCtl.text == ""
                        ? state.emailCtl.text.split('@')[0]
                        : state.orgCtl.text,
                ),
              ),
              Container(
                margin: kOuterRowTop10,
                child: TextFieldWithTitle(
                  title: FlutterI18n.translate(_ctx, 'display_name'),
                  // hint: FlutterI18n.translate(_ctx, 'display_name_hint'),
                  textInputAction: TextInputAction.done,
                  validator: (value) => Reg.onNotEmpty(_ctx, value),
                  controller: state.displayCtl
                    ..text = state.displayCtl.text == ""
                        ? state.emailCtl.text.split('@')[0]
                        : state.displayCtl.text,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 30.0),
        Container(
          padding: kRoundRow202,
          child: link(
            FlutterI18n.translate(_ctx, 'privacy_policy'),
            onTap: () => Tools.launchURL(Sys.privacyPolicy),
            alignment: Alignment.centerLeft,
          ),
        ),
        CheckboxLabelWidget(
          value: state.isCheckTerms,
          child: link(FlutterI18n.translate(_ctx, 'agree_conditions'),
              onTap: () => Tools.launchURL(Sys.AgreePolicy), alignment: Alignment.centerLeft),
          onChanged: (_) => dispatch(RegistrationActionCreator.isCheckTerms()),
        ),
        CheckboxLabelWidget(
          value: state.isCheckSend,
          text: FlutterI18n.translate(_ctx, 'send_marking_information'),
          onChanged: (_) => dispatch(RegistrationActionCreator.isCheckSend()),
        ),
      ],
    ),
    footer: PrimaryButton(
      onTap:
          state.isCheckTerms ? () => dispatch(SignUpActionCreator.onRegistrationContinue()) : null,
      buttonTitle: FlutterI18n.translate(_ctx, 'next'),
      minHeight: 46,
    ),
    backgroundColor: cardBackgroundColor,
  );
}
