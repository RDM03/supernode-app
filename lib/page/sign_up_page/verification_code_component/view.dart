import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/buttons/primary_button.dart';
import 'package:supernodeapp/common/components/page/paragraph.dart';
import 'package:supernodeapp/common/components/text_field/text_field_with_codes.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/spacing.dart';

import '../action.dart';
import 'state.dart';

Widget buildView(
    VerificationCodeState state, Dispatch dispatch, ViewService viewService) {
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
                                    isLast: index == state.listCtls.length - 1))
                                .toList()),
                      ),
                    ]),
                  ),
                  Spacer(),
                  PrimaryButton(
                      onTap: () => dispatch(
                          SignUpActionCreator.onVerificationContinue()),
                      buttonTitle: FlutterI18n.translate(_ctx, 'confirm'),
                      minHeight: 46),
                ],
              ))));
}
