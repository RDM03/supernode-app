import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:supernodeapp/theme/spacing.dart';

class AppBars {
  static signUpAppBar({Function onPress}){
    return AppBar(
      leading: IconButton(
        onPressed: onPress,
        icon: Image.asset(
          "assets/images/arrow-left.png",
          color: Colors.black,
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
          margin: kRoundRow202,
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
