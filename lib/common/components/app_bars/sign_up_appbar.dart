import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/font.dart';
import 'package:supernodeapp/theme/spacing.dart';

class AppBars {
  static backArrowAppBar({String title: '', Function onPress}){
    return AppBar(
      leading: IconButton(
        onPressed: onPress,
        icon: Icon(Icons.arrow_back_ios,
          color: Colors.black,
        ),
      ),
      centerTitle: true,
      backgroundColor: backgroundColor,
      elevation: 0,
      title: Text(
        title,
        style: kBigFontOfBlack,
      ),
    );
  }

  static backArrowSkipAppBar({Function onPress, String action = ""}) {
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
      backgroundColor: backgroundColor,
      elevation: 0,
    );
  }
}
