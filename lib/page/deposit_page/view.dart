import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:supernodeapp/common/components/column_spacer.dart';
import 'package:supernodeapp/common/components/loading_tiny.dart';
import 'package:supernodeapp/common/components/page/introduction.dart';
import 'package:supernodeapp/common/components/page/page_frame.dart';
import 'package:supernodeapp/common/components/page/page_nav_bar.dart';
import 'package:supernodeapp/common/components/page/paragraph.dart';
import 'package:supernodeapp/common/components/page/submit_button.dart';
import 'package:supernodeapp/theme/font.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(DepositState state, Dispatch dispatch, ViewService viewService) {
  var _ctx = viewService.context;

  return pageFrame(
    context: viewService.context,
    children: [
      pageNavBar(
        FlutterI18n.translate(_ctx, 'top_up'),
        onTap: () => Navigator.pop(viewService.context)
      ),
      smallColumnSpacer(),
      paragraph(FlutterI18n.translate(_ctx, 'address')),
      bigColumnSpacer(),

      Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              child: state.address.isEmpty ?
              loading(isSmall: true) :
              QrImage(
                key: Key('qrCodeTopUp'),
                data: state.address,
                version: QrVersions.auto,
                size: 240.0,
              ),
            ),
            middleColumnSpacer(),
            Text(
              state.address,
              textAlign: TextAlign.center,
              style: kMiddleFontOfGrey,
              key: Key('ethAddressTopUp'),
            )
          ],
        ),
      ),
      submitButton(
        FlutterI18n.translate(_ctx, 'copy_address'),
        onPressed: () => dispatch(DepositActionCreator.copy())
      ),
      paragraph(FlutterI18n.translate(_ctx, 'send_deposit_address')),
      introduction(FlutterI18n.translate(_ctx, 'send_coin_tip'),
        top: 5
      ),
      paragraph(FlutterI18n.translate(_ctx, 'deposit_confirm_tip')),
    ]
  );
}
