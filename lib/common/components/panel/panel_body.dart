import 'package:flutter/material.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/font.dart';

Widget panelBody(
    {String titleText,
    String subtitleText,
    String trailTitle,
    trailSubtitle,
    IconData icon,
    Function onPressed}) {
  var temp = trailSubtitle.split('(');
  String mxcPrice = temp[0].substring(0, temp[0].length - 1);
  String usdPrice = temp[1].substring(0, temp[1].length - 1);

  return Container(
    padding: EdgeInsets.all(10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
                child: IconButton(
              padding: EdgeInsets.zero,
              icon: Icon(
                icon,
                color: buttonPrimaryColor,
                size: 50,
              ),
              onPressed: onPressed,
            )),
            SizedBox(width: 12),
            Text(
              titleText,
              textAlign: TextAlign.left,
              style: kMiddleFontOfBlack,
            ),
            SizedBox(width: 5),
            Text(
              subtitleText,
              textAlign: TextAlign.left,
              style: kBigFontOfBlack,
            ),
          ],
        ),
        Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(trailTitle, style: kSmallFontOfGrey),
              Text(
                mxcPrice,
                style: kMiddleFontOfBlack,
              ),
              Text(
                usdPrice,
                style: kMiddleFontOfBlack,
              )
            ],
          ),
        ),
      ],
    ),
  );
}
