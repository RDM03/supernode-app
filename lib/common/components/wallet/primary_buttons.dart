import 'package:flutter/material.dart';
import 'package:supernodeapp/common/components/buttons/primary_button.dart';

import '../row_spacer.dart';

Widget primaryButtons({String buttonLabel1 = '',Function onTap1,String buttonLabel2 = '',Function onTap2}){
  return ListTile(
    title: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        PrimaryButton(
          buttonTitle: buttonLabel1,
          onTap: onTap1,
        ),
        smallRowSpacer(),
        PrimaryButton(
          buttonTitle: buttonLabel2,
          onTap: onTap2,
        )
      ]
    )
  );
}