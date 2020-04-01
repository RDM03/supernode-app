import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/theme.dart';

class PrimaryButton extends StatelessWidget {
  PrimaryButton({@required this.onTap, @required this.buttonTitle});

  final String buttonTitle;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: onTap,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(3)),
      ),
      color: buttonPrimaryColor,
      child: Text(
        buttonTitle,
        textAlign: TextAlign.center,
        style: kTitleTextStyle2,
      ),
    );
  }
}
