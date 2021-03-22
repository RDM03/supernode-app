import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/font.dart';

class AppBars {
  static backArrowAppBar({String title: '', Function onPress, Function onTitlePress, Color color}) {
    return AppBar(
      leading: IconButton(
        onPressed: onPress,
        icon: Icon(
          Icons.arrow_back_ios,
          color: Colors.black,
        ),
      ),
      centerTitle: true,
      backgroundColor: color ?? backgroundColor,
      elevation: 0,

      title: (onTitlePress == null)
          ? Text(title, style: kBigFontOfBlack)
          : GestureDetector(
        onTap: onTitlePress,
        child: Text(title, style: kBigFontOfBlack),
        key: ValueKey('logoFinder')
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
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }
}
