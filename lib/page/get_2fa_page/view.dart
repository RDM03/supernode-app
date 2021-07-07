import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/buttons/primary_button.dart';
import 'package:supernodeapp/common/components/page/page_frame.dart';
import 'package:supernodeapp/common/components/page/page_nav_bar.dart';
import 'package:supernodeapp/common/components/text_field/text_field_with_codes.dart';
import 'package:supernodeapp/theme/colors.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    Get2FAState state, Dispatch dispatch, ViewService viewService) {
  var _ctx = viewService.context;
  state.isEnabled = true;
  return pageFrame(context: viewService.context, children: [
    pageNavBar(state.title ?? '',
        onTap: () => Navigator.pop(viewService.context)),
    Container(
      padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
      alignment: FractionalOffset(0.5, 0.5),
      child: Column(children: <Widget>[
        Text(FlutterI18n.translate(_ctx, 'wthdr_ent_code_01'),
            style: TextStyle(
              color: blackColor,
              fontWeight: FontWeight.w400,
              fontSize: 24,
            )),
      ]),
    ),
    Container(
      padding: EdgeInsets.symmetric(vertical: 5.0),
      alignment: FractionalOffset(0.5, 0.5),
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
      alignment: FractionalOffset(0.5, 0.5),
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
    Container(
      padding: EdgeInsets.fromLTRB(20.0, 40.0, 0.0, 00.0),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(FlutterI18n.translate(_ctx, 'wthdr_ent_code_04'),
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
              padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 80.0),
              child: Row(
                  key: Key('enterOtp'),
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: state.listCtls
                      .asMap()
                      .keys
                      .map((index) => textfieldWithCodes(
                          context: _ctx,
                          controller: state.listCtls[index],
                          isLast: index == state.listCtls.length - 1,
                          key: Key('otp_$index')))
                      .toList()),
            ),
          ]),
    ),
    Container(
      padding: EdgeInsets.fromLTRB(0.0, 280.0, 0.0, 00.0),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            PrimaryButton(
                key: Key('confirmOtp'),
                onTap: () => dispatch(Get2FAActionCreator.onSubmit()),
                buttonTitle: FlutterI18n.translate(_ctx, 'confirm'),
                minHeight: 46),
          ]),
    ),
  ]);
}
