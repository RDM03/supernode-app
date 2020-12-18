import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:supernodeapp/theme/font.dart';
import 'package:supernodeapp/theme/spacing.dart';

class AppBars {
  static signUpAppBar({Function onPress}){
    return AppBar(
      leading: IconButton(
        onPressed: onPress,
        icon: Icon(Icons.arrow_back_ios,
          color: Colors.black,
        ),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }

  static signUpSkipAppBar({Function onPress, String action = ""}) {
    return AppBar(
      leading: IconButton(
        onPressed: onPress,
        icon: Icon(Icons.arrow_back_ios, color: Colors.black),
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: onPress,
          child: Center(
            child: Text(action, style: kBigFontOfBlack),
          ),
        )
      ],
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }
}
