import 'package:flutter/cupertino.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/utils/utils.dart';
import 'package:supernodeapp/theme/font.dart';

Widget proceedDialog(BuildContext context, double amount) =>
    CupertinoActionSheet(
      message: Column(
        children: [
          Text(
            FlutterI18n.translate(context, 'add_fuel'),
            style: kMiddleFontOfBlue,
          ),
          SizedBox(height: 10),
          Text(
            FlutterI18n.translate(context, 'add_fuel_confirm')
                .replaceAll('{0}', Tools.priceFormat(amount, range: 2)),
            style: kSmallFontOfGrey,
          ),
        ],
      ),
      actions: [
        CupertinoActionSheetAction(
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(
            FlutterI18n.translate(context, 'proceed'),
            style: kBigFontOfBlue,
          ),
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        child: Text(
          FlutterI18n.translate(context, 'cancel_normalized'),
          style: kBigFontOfGrey,
        ),
        onPressed: () => Navigator.of(context).pop(),
      ),
    );
