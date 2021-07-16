import 'package:flutter/cupertino.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/utils/utils.dart';
import 'package:supernodeapp/theme/font.dart';
import 'package:supernodeapp/theme/theme.dart';

Widget proceedDialog(BuildContext context, double amount) =>
    CupertinoActionSheet(
      message: Column(
        children: [
          Text(
            FlutterI18n.translate(context, 'send_to_wallet'),
            style: FontTheme.of(context).middle.mxc(),
          ),
          SizedBox(height: 10),
          Text(
            FlutterI18n.translate(context, 'send_to_wallet_confirm')
                .replaceAll('{0}', Tools.priceFormat(amount, range: 2)),
            style: FontTheme.of(context).small.secondary(),
          ),
        ],
      ),
      actions: [
        CupertinoActionSheetAction(
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(
            FlutterI18n.translate(context, 'proceed'),
            style: FontTheme.of(context).big.mxc(),
          ),
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        child: Text(
          FlutterI18n.translate(context, 'cancel_normalized'),
          style: FontTheme.of(context).big.secondary(),
        ),
        onPressed: () => Navigator.of(context).pop(),
      ),
    );
