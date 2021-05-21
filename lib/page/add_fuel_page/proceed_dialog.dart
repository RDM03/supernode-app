import 'package:flutter/cupertino.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/theme/font.dart';

Widget proceedDialog(BuildContext context) => CupertinoActionSheet(
      message: Column(
        children: [
          Text(
            'Fuel up',
            style: kMiddleFontOfBlue,
          ),
          SizedBox(height: 10),
          Text(
            'You are about to fuel up 5000 MXC. Please note if you withdraw MXC from the fuel your mining efficiency will decrease.',
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
          FlutterI18n.translate(context, 'got_it'),
          style: kBigFontOfGrey,
        ),
        onPressed: () => Navigator.of(context).pop(),
      ),
    );
