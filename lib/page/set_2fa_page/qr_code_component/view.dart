import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/buttons/primary_button.dart';
import 'package:supernodeapp/common/components/page/paragraph.dart';
import 'package:supernodeapp/theme/font.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/spacing.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../action.dart';
import 'action.dart';
import 'state.dart';

Widget buildView(QRCodeState state, Dispatch dispatch, ViewService viewService) {
  var _ctx = viewService.context;
print('enter security');
  print(state.isEnabled);
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
                  //paragraph(FlutterI18n.translate(_ctx, 'send_email')),
                  Form(
                    key: state.formKey,
                    autovalidate: false,
                    child: Column(
                        children: <Widget>[
                          Wrap(
                            runSpacing: 10.0,
                            children: <Widget>[
                              paragraph(FlutterI18n.translate(_ctx,'qr_desc_01')),
                              paragraph(FlutterI18n.translate(_ctx,'qr_desc_02')),
                              Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                    child: Text(FlutterI18n.translate(_ctx,'qr_desc_03')),
                                  )
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                    child: Text(FlutterI18n.translate(_ctx,'qr_desc_04')),
                                  )
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 20.0),
                                    child: Text(FlutterI18n.translate(_ctx,'qr_desc_05')),
                                  )
                                ],
                              ),
                              Center(
                                child: QrImage(
                                  data: state.url,
                                  version: QrVersions.auto,
                                  size: 240.0,
                                ),
                              ),
                              SizedBox(height: 10.0),
                              Center(
                                child: SelectableText(state.secret,
                                  textAlign: TextAlign.center,
                                  style: kMiddleFontOfGrey,
                                )
                              ),
                            ],
                          ),
                        ]
                    ),
                  ),
                  Spacer(),
                  state.isEnabled ?
                  PrimaryButton(
                      onTap: () => dispatch(Set2FAActionCreator.onSetDisable()),
                      buttonTitle: FlutterI18n.translate(_ctx, 'continue'),
                      minHeight: 46
                  ):
                  PrimaryButton(
                      //onTap: () => dispatch(Set2FAActionCreator.onSetEnable()),
                      onTap: () => dispatch(Set2FAActionCreator.onEnterSecurityContinue('disable')),
                      buttonTitle: FlutterI18n.translate(_ctx, 'continue'),
                      minHeight: 46
                  ),
                ],
              )
          )
      )
  );
}
