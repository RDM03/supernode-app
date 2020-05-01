import 'package:flutter/material.dart';
import 'package:supernodeapp/theme/font.dart';
import 'package:supernodeapp/theme/spacing.dart';

Widget titleDetailRow({String name = '',dynamic value}){
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
        Text(
          '${value} MXC',
          textAlign: TextAlign.left,
          style: kBigFontOfBlack,
        )
      ],
    )
  );
}