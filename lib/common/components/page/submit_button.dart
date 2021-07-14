import 'package:flutter/material.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/theme.dart';

Widget submitButton(
  String label, {
  double top = 34,
  Function onPressed,
  Key key,
  Color color,
}) {
  return Builder(
    builder: (context) => Container(
      height: 45,
      width: double.infinity,
      margin: EdgeInsets.only(top: top),
      child: FlatButton(
        key: key,
        onPressed: onPressed,
        color: color ?? ColorsTheme.of(context).dhxBlue,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: color ?? ColorsTheme.of(context).dhxBlue,
            width: 1,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.all(Radius.circular(3)),
        ),
        textColor: ColorsTheme.of(context).textPrimaryAndIcons,
        padding: EdgeInsets.all(0),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: ColorsTheme.of(context).textPrimaryAndIcons,
            fontFamily: "Roboto",
            fontWeight: FontWeight.w400,
            fontSize: 14,
          ),
        ),
      ),
    ),
  );
}

Widget whiteBorderButton(
  String label, {
  double top = 34,
  Function onPressed,
  Key key,
}) {
  final Color color = (onPressed == null) ? greyColor : whiteColor;
  return Container(
    height: 45,
    margin: EdgeInsets.only(top: top),
    child: FlatButton(
      key: key,
      onPressed: onPressed,
      color: Colors.transparent,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: color,
          width: 1,
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.all(Radius.circular(3)),
      ),
      textColor: color,
      padding: EdgeInsets.all(0),
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: color,
          fontFamily: "Roboto",
          fontWeight: FontWeight.w400,
          fontSize: 14,
        ),
      ),
    ),
  );
}
