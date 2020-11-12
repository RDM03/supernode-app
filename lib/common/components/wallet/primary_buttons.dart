import 'package:flutter/material.dart';
import 'package:supernodeapp/common/components/buttons/primary_button.dart';

import '../row_spacer.dart';

Widget primaryButtons({Key key1,String buttonLabel1 = '',Function onTap1,Key key2,String buttonLabel2 = '',Function onTap2}){
  return ListTile(
    title: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        PrimaryButton(
          key: key1,
          buttonTitle: buttonLabel1,
          onTap: onTap1,
        ),
        smallRowSpacer(),
        PrimaryButton(
          key: key2,
          buttonTitle: buttonLabel2,
          onTap: onTap2,
        )
      ]
    )
  );
}