import 'package:flutter/material.dart';
import 'package:supernodeapp/common/components/loading_flash.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/font.dart';

Widget panelBody({
  String titleText,
  String subtitleText,
  String trailTitle,
  trailSubtitle,
  IconData icon,
  Function onPressed,
  bool loading = false,
  bool trailLoading,
}) {
  var temp = trailSubtitle.split('(');
  String mxcPrice = temp[0].substring(0, temp[0].length - 1);

  return ListTile(
    contentPadding: EdgeInsets.zero,
    leading: Container(
        margin: const EdgeInsets.only(left: 10),
        child: IconButton(
          padding: EdgeInsets.zero,
          icon: Icon(
            icon,
            color: buttonPrimaryColor,
            size: 50,
          ),
          onPressed: onPressed,
        )),
    title: Text(
      titleText,
      textAlign: TextAlign.left,
      style: kMiddleFontOfBlack,
    ),
    subtitle: loading
        ? loadingFlash(
            child: Text(
              subtitleText,
              textAlign: TextAlign.left,
              style: kBigFontOfBlack,
            ),
          )
        : Text(
            subtitleText,
            textAlign: TextAlign.left,
            style: kBigFontOfBlack,
          ),
    trailing: Container(
      margin: EdgeInsets.only(top: 10, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(trailTitle, style: kSmallFontOfGrey),
          (trailLoading ?? loading)
              ? loadingFlash(
                  child: Text(
                    mxcPrice,
                    style: kMiddleFontOfBlack,
                  ),
                )
              : Text(
                  mxcPrice,
                  style: kMiddleFontOfBlack,
                )
        ],
      ),
    ),
  );
}
