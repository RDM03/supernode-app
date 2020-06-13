import 'package:flutter/material.dart';
import 'package:supernodeapp/common/components/loading_flash.dart';
import 'package:supernodeapp/theme/spacing.dart';

Widget rowRight(String text,{bool loading = false,TextStyle style}){
  return Container(
    margin: kRoundRow202,
    alignment: Alignment.centerRight,
    child: loading ? loadingFlash(
      child: Text(
        text,
        style: style
      ),
    ) : Text(
      text,
      style: style
    )
  );
}