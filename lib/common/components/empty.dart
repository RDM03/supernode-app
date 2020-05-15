import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/theme/font.dart';

Widget empty(BuildContext context){
  return Container(
    alignment: Alignment.center,
    height: 50,
    child: Text(
      FlutterI18n.translate(context,'no_data'),
      style: kMiddleFontOfGrey,
    ),
  );
}