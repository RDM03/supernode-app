import 'package:flutter/cupertino.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/utils/utils.dart';
import 'package:supernodeapp/theme/theme.dart';

Widget proceedDialog(BuildContext context, double amount) =>
    CupertinoActionSheet(
      actions: [
        Container(
          color: ColorsTheme.of(context).boxComponents,
          child: CupertinoActionSheetAction(
            onPressed: () => 'no action',
            child: Text(
              FlutterI18n.translate(context, 'add_fuel'),
              style: FontTheme.of(context).middle.mxc(),
            ),
          ),
        ),
        Container(
          color: ColorsTheme.of(context).boxComponents,
          child: CupertinoActionSheetAction(
            onPressed: () => 'no action',
            child: Text(
              FlutterI18n.translate(context, 'add_fuel_confirm')
                  .replaceAll('{0}', Tools.priceFormat(amount, range: 2)),
              style: FontTheme.of(context).small.secondary(),
            ),
          ),
        ),
        Container(
          color: ColorsTheme.of(context).boxComponents,
          child: CupertinoActionSheetAction(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(
              FlutterI18n.translate(context, 'proceed'),
              style: FontTheme.of(context).big.mxc(),
            ),
          ),
        ),
      ],
      cancelButton: Container(
        color: ColorsTheme.of(context).boxComponents,
        child: CupertinoActionSheetAction(
          child: Text(
            FlutterI18n.translate(context, 'cancel_normalized'),
            style: FontTheme.of(context).big.secondary(),
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
    );
