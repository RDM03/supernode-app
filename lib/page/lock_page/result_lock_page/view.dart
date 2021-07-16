import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/page/done.dart';
import 'package:supernodeapp/common/components/page/page_frame.dart';
import 'package:supernodeapp/common/components/page/page_nav_bar.dart';
import 'package:supernodeapp/common/components/page/submit_button.dart';
import 'package:supernodeapp/common/components/page/title.dart';
import 'package:supernodeapp/theme/font.dart';
import 'package:supernodeapp/theme/theme.dart';

import 'state.dart';

Widget buildView(
    ResultLockPageState state, Dispatch dispatch, ViewService viewService) {
  final context = viewService.context;

  return GestureDetector(
    key: Key('lockAmountView'),
    onTap: () =>
        FocusScope.of(viewService.context).unfocus(),
    child: pageFrame(
      context: viewService.context,
      scrollable: false,
      margin: EdgeInsets.only(top: 60),
      children: [
        pageNavBar(
          FlutterI18n.translate(context, 'dhx_mining'),
          onTap: () => Navigator.of(context).pop(),
        ),
        SizedBox(height: 10),
        title(FlutterI18n.translate(context, 'confirmed')),
        done(),
        SizedBox(height: 30),
        SizedBox(
          width: double.infinity,
          child: Text(
            FlutterI18n.translate(context, 'transaction_id') +
                ': ' +
                state.transactionId,
            style: FontTheme.of(context).big(),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          child: Text(
            FlutterI18n.translate(context, 'congrats_mining'),
            key: Key('congratsMiningText'),
            style: FontTheme.of(context).big.secondary(),
            textAlign: TextAlign.center,
          ),
        ),
        Spacer(),
        submitButton(
          FlutterI18n.translate(context, 'done'),
          onPressed: () => Navigator.pop(viewService.context, true),
          key: ValueKey('submitButton'),
        ),
        SizedBox(height: 50),
      ],
    ),
  );
}
