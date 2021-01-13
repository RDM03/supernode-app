import 'package:flutter/material.dart';
import 'package:supernodeapp/common/components/loading_flash.dart';
import 'package:supernodeapp/theme/font.dart';

Widget profile({keyTitle, keySubtitle, String name = '', bool loading = false, String position = '', EdgeInsetsGeometry contentPadding, Widget trailing, Function onTap}){
  return ListTile(
    contentPadding: contentPadding,
    leading: Icon(
      Icons.account_circle,
      size: 44,
    ),
    title: loading ? loadingFlash(
      child: Text(
          name,
          key: keyTitle,
          style: kBigFontOfBlack
      ),
    ) : Text(
      name,
      key: keyTitle,
      style: kBigFontOfBlack,
    ),
    subtitle: loading ? loadingFlash(
      child: Text(
        position,
        key: keySubtitle,
        style: kMiddleFontOfGrey,
      ),
    ) : Text(
      position,
      key: keySubtitle,
      style: kMiddleFontOfGrey,
    ),
    trailing: trailing,
    onTap: onTap,
  );
}