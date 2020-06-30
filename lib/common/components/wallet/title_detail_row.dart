import 'package:flutter/material.dart';
import 'package:supernodeapp/common/components/loading_flash.dart';
import 'package:supernodeapp/theme/font.dart';
import 'package:supernodeapp/theme/spacing.dart';

Widget titleDetailRow({String name = '',dynamic value,bool loading = false}){
  return Container(
    padding: kRoundRow205,
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
            '$value MXC',
            textAlign: TextAlign.left,
            style: kBigFontOfBlack,
          )
        ) : Text(
          '$value MXC',
          textAlign: TextAlign.left,
          style: kBigFontOfBlack,
        )
      ],
    )
  );
}