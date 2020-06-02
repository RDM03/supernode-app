import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/buttons/primary_button.dart';
import 'package:supernodeapp/common/components/page/paragraph.dart';
import 'package:supernodeapp/common/components/text_field/text_field_with_codes.dart';
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
                              paragraph('Authenticator apps allow you to generate security codes on your mobile device.'),
                              paragraph('To configure the authenticator app.'),
                              Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                    child: Text('1. Open your authenticator app and add a new time-based token.'),
                                  )
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                    child: Text('2. Scan the QR code below.'),
                                  )
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 20.0),
                                    child: Text('3. click continue button'),
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
