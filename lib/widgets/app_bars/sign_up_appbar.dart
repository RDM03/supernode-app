import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:supernodeapp/theme/dimens.dart';

class AppBars {
  static signUpAppBar({Function onPress}) {
    return AppBar(
      leading: IconButton(
        onPressed: onPress,
        icon: Image.asset(
          "assets/images/arrow-left.png",
        ),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }
  static signUpSkipAppBar({Function onPress}) {
    return AppBar(
      leading: IconButton(
        onPressed: onPress,
        icon: Image.asset(
          "assets/images/arrow-left.png",
        ),
      ),
      actions: <Widget>[
        Container(
          margin: EdgeInsets.only(right: kBodyMargin),
          child: Center(
            child: Text(
              "skip",
            ),
          ),
        )
      ],
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }
}
