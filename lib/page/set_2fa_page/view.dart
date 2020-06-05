import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/column_spacer.dart';
import 'package:supernodeapp/common/components/page/page_frame.dart';
import 'package:supernodeapp/common/components/page/page_nav_bar_back.dart';
import 'package:supernodeapp/common/utils/reg.dart';
import 'package:supernodeapp/theme/spacing.dart';
import 'package:supernodeapp/common/components/page/link.dart';

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
                        fontWeight: FontWeight.bold,
                      ),
                  ),
                  Switch(
                    value: state.isEnabled,
                    onChanged: (value) {
                      if(value){
                        dispatch(Set2FAActionCreator.onGetTOTPConfig(240));
                      }else{
                        dispatch(Set2FAActionCreator.onEnterSecurityContinue("enable"));
                      }
                    },
                    activeTrackColor: Colors.lightGreenAccent,
                    activeColor: Colors.green,
                  ),
                ],
              ),
            ),
            smallColumnSpacer(),
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(left: 5.0, right: 20.0),
                    child: state.isEnabled ?
                    Row(
                      children: <Widget>[
                        link(
                            //FlutterI18n.translate(_ctx, 'learn_more'),
                            'Disable 2FA With Recovery code',
                            onTap: () => dispatch(Set2FAActionCreator.onEnterRecoveryContinue()),
                            alignment: Alignment.centerLeft
                        ),
                      ],
                    ) :Text(""),
                  ),
                  /*Container(
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
                    ) :Text(""),
                  ),*/
                  middleColumnSpacer(),
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