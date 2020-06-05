import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/buttons/primary_button.dart';
import 'package:supernodeapp/common/components/page/paragraph.dart';
import 'package:supernodeapp/common/components/text_field/text_field_with_title.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/spacing.dart';

import '../action.dart';
import 'state.dart';

Widget buildView(EnterNonOTPSecurityCodeState state, Dispatch dispatch, ViewService viewService) {
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
                  paragraph(FlutterI18n.translate(_ctx,'enter_security_01')),
                  Form(
                    key: state.formKey,
                    autovalidate: false,
                    child: Column(
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.only(top: 40),
                            child: TextFieldWithTitle(
                              title: FlutterI18n.translate(_ctx, 'withdraw_amount'),
                              textInputAction: TextInputAction.next,
                              controller: state.secretCtl,
                            ),
                          ),
                        ]
                    ),
                  ),
                  Spacer(),
                  state.isEnabled ?
                  PrimaryButton(
                      onTap: () => dispatch(Set2FAActionCreator.onSetDisable()),
                      buttonTitle: FlutterI18n.translate(_ctx, 'confirm'),
                      minHeight: 46
                  ):
                  PrimaryButton(
                      onTap: () => dispatch(Set2FAActionCreator.onSetEnable()),
                      buttonTitle: FlutterI18n.translate(_ctx, 'confirm'),
                      minHeight: 46
                  ),
                ],
              )
          )
      )
  );
}
