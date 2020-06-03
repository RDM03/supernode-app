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
        FlutterI18n.translate(_ctx,'change_password'),
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
                      'Set 2FA',
                      style: TextStyle(
                        //fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        //letterSpacing: 2.0,
                        //color: Colors.grey[600],
                        //fontFamily: 'IndieFlower',
                      ),
                  ),
                  Switch(
                    value: state.isEnabled ?? false,
                    onChanged: (value) {
                      dispatch(Set2FAActionCreator.isEnabled(value));
                    },
                    activeTrackColor: Colors.lightGreenAccent,
                    activeColor: Colors.green,
                  ),

                ],
              ),
            ),

            smallColumnSpacer(),
            Text(
              'Set up 2FA using Google authentication.',
            ),
            PrimaryButton(
              buttonTitle: FlutterI18n.translate(_ctx, 'deposit'),
              //onTap: () => dispatch(HomeActionCreator.onOperate('deposit')),
            ),
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: !state.isEnabled ?
                    loading(isSmall: true) :
                    QrImage(
                      data: '0x7839ddd6489d5279c51e68687a4f289d4698c299',
                      version: QrVersions.auto,
                      size: 240.0,
                    ),
                  ),
                  middleColumnSpacer(),
                  Text(
                    '0x7839ddd6489d5279c51e68687a4f289d4698c299',
                    textAlign: TextAlign.center,
                    style: kMiddleFontOfGrey,
                  )
                ],
              ),
            ),
          ]
        )
      ),
      submitButton(
        FlutterI18n.translate(_ctx,'confirm'),
        //onPressed: () => dispatch(ChangePasswordActionCreator.onConfirm())
      )
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