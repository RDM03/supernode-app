import 'package:flutter/material.dart';
import 'package:supernodeapp/common/components/loading_flash.dart';
import 'package:supernodeapp/theme/font.dart';
import 'package:supernodeapp/theme/spacing.dart';

Widget titleDetailRow ({Key key, String name = '', dynamic value, bool loading = false, String token = 'MXC', bool disabled = false}) {
  return Container(
    padding: kRoundRow15_5,
    child: Row(
      children: <Widget>[
        Text(
          name,
          textAlign: TextAlign.left,
          style: kSmallFontOfGrey,
        ),
        Spacer(),
        loading ? loadingFlash(
          child: Text(
            '$value${token.isNotEmpty?' $token':''}',
            key: key,
            textAlign: TextAlign.left,
            style: kBigFontOfBlack,
          )
        ) : Text(
          '$value${token.isNotEmpty?' $token':''}',
          key: key,
          textAlign: TextAlign.left,
          style: disabled? kBigFontOfGrey : kBigFontOfBlack,
        )
      ],
    )
  );
}