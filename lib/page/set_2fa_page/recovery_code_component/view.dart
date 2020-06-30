import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/buttons/primary_button.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/spacing.dart';

import '../action.dart';
import 'action.dart';
import 'state.dart';

Widget buildView(RecoveryCodeState state, Dispatch dispatch, ViewService viewService) {
  var _ctx = viewService.context;
  print('state.recoveryCode');
  print(state.recoveryCode);
  print(state.isAgreed);
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
        child: Center(
          child: ListView(
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            //paragraph(FlutterI18n.translate(_ctx, 'send_email')),
            Text(
              FlutterI18n.translate(_ctx,'recovery_cd_desc_01'),
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold ,fontSize: 16.0),
            ),
            SizedBox(height: 10.0),
          Wrap(
            children: <Widget>[
              Text(
                FlutterI18n.translate(_ctx,'recovery_cd_desc_02'),
              ),
              Text(
                FlutterI18n.translate(_ctx,'recovery_cd_desc_03'),
                style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold ,fontSize: 14.0),
              ),
            ]
          ),
            SizedBox(height: 30.0),
            Wrap(
              spacing: 40.0,
              runSpacing: 20.0,
              children: state.recoveryCode.map((item) => new Text(item,
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold ,fontSize: 24.0),
                )
              ).toList()
            ),

            // Spacer(),
            Row(
              children: <Widget>[
                Checkbox(
                    value: state.isAgreed,
                    onChanged: (bool value) {
                      dispatch(RecoveryCodeActionCreator.isAgreed(value));
                    },
                ),
                Text(FlutterI18n.translate(_ctx,'recovery_cd_desc_04'))
              ],
            ),
            state.isAgreed ?
            PrimaryButton(
              onTap: () => dispatch(Set2FAActionCreator.onRecoveryCodeContinue()),
              buttonTitle: FlutterI18n.translate(_ctx, 'confirm'),
              minHeight: 46
            ):
            Text(''),
          ],
          ),
        )
      )
    )
  );
}
