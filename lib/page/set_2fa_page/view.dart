import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:supernodeapp/common/components/buttons/primary_button.dart';
import 'package:supernodeapp/common/components/column_spacer.dart';
import 'package:supernodeapp/common/components/page/page_frame.dart';
import 'package:supernodeapp/common/components/page/page_nav_bar_back.dart';
import 'package:supernodeapp/common/components/page/submit_button.dart';
import 'package:supernodeapp/common/components/text_field/text_field_with_title.dart';
import 'package:supernodeapp/common/utils/reg.dart';
import 'package:supernodeapp/theme/spacing.dart';
import 'package:supernodeapp/common/components/loading_tiny.dart';
import 'package:supernodeapp/theme/font.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(Set2FAState state, Dispatch dispatch, ViewService viewService) {
  var _ctx = viewService.context;

  return pageFrame(
    context: viewService.context,
    children: [
      pageNavBarBack(
        FlutterI18n.translate(_ctx,'set_fa_01'),
        onTap: () => Navigator.of(viewService.context).pop()
      ),
      Form(
        key: state.formKey,
        child: Column(
          children: <Widget>[
            bigColumnSpacer(),
            Container(
              margin: kRoundRow5,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                      FlutterI18n.translate(_ctx,'set_fa_02'),
                      style: TextStyle(
                        //fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        //letterSpacing: 2.0,
                        //color: Colors.grey[600],
                        //fontFamily: 'IndieFlower',
                      ),
                  ),
                  Switch(
                    value: state.isEnabled,
                    onChanged: (value) {
                      if(value){
                        //dispatch(Set2FAActionCreator.onQRCodeContinue());
                        dispatch(Set2FAActionCreator.onGetTOTPConfig(240));
                        //dispatch(SettingsActionCreator.onSettings('security'))

                      }else{
                        dispatch(Set2FAActionCreator.onEnterSecurityContinue("enable"));
                      }
                      //regenerate
                      //
                    },
                    activeTrackColor: Colors.lightGreenAccent,
                    activeColor: Colors.green,
                  ),

                ],
              ),
            ),

            smallColumnSpacer(),
            /*Text(
              'Set up 2FA using Google authentication.',
            ),
            PrimaryButton(
              buttonTitle: FlutterI18n.translate(_ctx, 'deposit'),
              onTap: () => dispatch(HomeActionCreator.onOperate('deposit')),
            ),*/
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: state.isEnabled ?
                    Row(
                      children: <Widget>[
                        Checkbox(
                            value: state.regenerate,
                            onChanged: (value) {
                              dispatch(Set2FAActionCreator.isRegenerate(value));
                            }
                        ),
                        Text('Regenerate recovery code')
                      ],
                    ) :
                    /*state.secret != '' ?
                        Wrap(
                          runSpacing: 10.0,
                          children: <Widget>[
                            Text('Authenticator apps allow you to generate security codes on your mobile device.'),
                            Text('To configure the authenticator app.'),
                            Text('1. Open your authenticator app and add a new time-based token.'),
                            Text('2. Scan the QR code below        '),
                            Text('3. click continue button'),
                            Center(
                              child: QrImage(
                                data: state.url,
                                version: QrVersions.auto,
                                size: 240.0,
                              ),
                            ),
                            Center(
                              child: PrimaryButton(
                                  //onTap: () => dispatch(Set2FAActionCreator.onEnterSecurityContinue("disable")),
                                  onTap: () => dispatch(Set2FAActionCreator.onQRCodeContinue()),
                                  buttonTitle: FlutterI18n.translate(_ctx, 'continue'),
                                  minHeight: 46
                              )
                            )
                          ],
                        )
                    :*/Text(""),
                  ),
                  middleColumnSpacer(),
                  /*Text(
                    state.secret,
                    textAlign: TextAlign.center,
                    style: kMiddleFontOfGrey,
                  )*/
                ],
              ),
            ),
          ]
        )
      ),

    ]
  );
}

String _onValidConfirmPassword(BuildContext context,String value1,String value2){
  String res = Reg.isEmpty(value1);
  if(res != null) return FlutterI18n.translate(context, res);  

  res = Reg.isEqual(value1,value2,'password');

  if(res != null){
    return FlutterI18n.translate(context,res);
  }

  return null;

}