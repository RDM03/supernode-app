import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/theme.dart';

class SecondaryButton extends StatelessWidget {
  SecondaryButton({@required this.onTap, @required this.buttonTitle});

  final String buttonTitle;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: onTap,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: buttonPrimaryColor,
          width: 1,
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.all(Radius.circular(3)),
      ),
      color: buttonSecondaryColor,
      child: Text(
        buttonTitle,
        textAlign: TextAlign.center,
        style: kTitleTextStyle3,
      ),
    );
  }
}
