import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:supernodeapp/theme/colors.dart';

class RadioButtonWithText extends StatelessWidget {
  RadioButtonWithText({@required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          flex: 6,
          child: Text(
            text,
            textAlign: TextAlign.left,
            // style: kTitleTextStyle4,
          ),
        ),
        Expanded(
          flex: 1,
          child: Switch(
            value: true,
            onChanged: (value) {},
            activeColor: buttonPrimaryColor,
            activeTrackColor: buttonPrimaryColorAccent,
          ),
        ),
      ],
    );
  }
}
