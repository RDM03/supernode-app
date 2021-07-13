import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/buttons/primary_button.dart';
import 'package:supernodeapp/common/components/text_field/text_field_with_title.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/spacing.dart';
import 'package:supernodeapp/theme/theme.dart';

import '../action.dart';
import 'state.dart';

Widget buildView(
    EnterRecoveryCodeState state, Dispatch dispatch, ViewService viewService) {
  var _ctx = viewService.context;

  return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ColorsTheme.of(_ctx).secondaryBackground,
      appBar: AppBar(
        iconTheme:
            IconThemeData(color: ColorsTheme.of(_ctx).textPrimaryAndIcons),
        title: Text(
            state.isEnabled
                ? FlutterI18n.translate(_ctx, 'disable_2FA')
                : FlutterI18n.translate(_ctx, 'enable_2FA'),
            style: TextStyle(
              color: ColorsTheme.of(_ctx).textPrimaryAndIcons,
              fontWeight: FontWeight.w400,
              fontSize: 18,
            )),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
          child: Container(
              padding: kRoundRow2002,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(FlutterI18n.translate(_ctx, 'wthdr_ent_code_01'),
                              style: TextStyle(
                                color: ColorsTheme.of(_ctx).textPrimaryAndIcons,
                                fontWeight: FontWeight.w400,
                                fontSize: 24,
                              )),
                        ]),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 5.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(FlutterI18n.translate(_ctx, 'wthdr_ent_code_02'),
                              style: TextStyle(
                                color: greyColorShade600,
                                fontWeight: FontWeight.w400,
                              )),
                        ]),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 80.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(FlutterI18n.translate(_ctx, 'wthdr_ent_code_03'),
                              style: TextStyle(
                                color: greyColorShade600,
                                fontWeight: FontWeight.w400,
                              )),
                        ]),
                  ),
                  Form(
                    key: state.formKey,
                    autovalidate: false,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.only(
                                top: 0, left: 40, right: 40),
                            child: TextFieldWithTitle(
                              title: FlutterI18n.translate(
                                  _ctx, 'wthdr_ent_code_04'),
                              textInputAction: TextInputAction.next,
                              controller: state.otpCodeCtl,
                            ),
                          ),
                        ]),
                  ),
                  Spacer(),
                  PrimaryButton(
                      onTap: () => dispatch(Set2FAActionCreator.onSetDisable()),
                      buttonTitle: FlutterI18n.translate(_ctx, 'confirm'),
                      minHeight: 46)
                ],
              ))));
}
