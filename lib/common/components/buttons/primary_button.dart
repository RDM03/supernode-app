import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/font.dart';

class PrimaryButton extends StatelessWidget {
  PrimaryButton({
    @required this.onTap,
    @required this.buttonTitle,
    this.minHeight = 36,
  });

  final String buttonTitle;
  final Function onTap;
  final double minHeight;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: minHeight),
      child: RaisedButton(
        onPressed: onTap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(3)),
        ),
        color: buttonPrimaryColor,
        child: Text(
          buttonTitle,
          textAlign: TextAlign.center,
          style: kMiddleFontOfWhite,
        ),
      ),
    );
  }
}
