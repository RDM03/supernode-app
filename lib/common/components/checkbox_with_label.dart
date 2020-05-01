import 'package:flutter/material.dart';

import 'page/introduction.dart';

Widget checkbox_with_label({bool value,String label,Function(bool) onChanged}){
  return  Container(
    child: Row(
      children: <Widget>[
        Checkbox(
          value: value, 
          onChanged: onChanged
        ),
        Expanded(
          child: introduction(
            label,
            left: 0,
            right: 0,
            top: 0,
            bottom: 0
          )
        )
      ],
    ),
  );
}