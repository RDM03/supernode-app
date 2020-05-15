import 'package:flutter/material.dart';
import 'package:supernodeapp/common/configs/images.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/font.dart';
import 'package:supernodeapp/theme/spacing.dart';

Widget summaryRow({String image = '',String title = '',String subtitle = '',String number ='',String price = ''}){
  return ListTile(
    leading: Stack(
      alignment: Alignment.center,
      children: [
        Image.asset(
          AppImages.blueCircle,
          fit: BoxFit.none,
          color: lightBlue,
        ),
        Image.asset(
          image,
          fit: BoxFit.none,
        )
      ]
    ),
    title: Text(
      title,
      style: kMiddleFontOfBlack,
    ),
    subtitle: Text(
      number,
      style: kBigFontOfBlue,
    ),
    trailing: Container(
      margin: kOuterRowTop10,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Text(
            subtitle,
            style: kSmallFontOfGrey,
          ),
          Text(
            price,
            style: kMiddleFontOfBlack,
          )
        ],
      ),
    )
  );
}